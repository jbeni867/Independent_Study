(ns delve.core
  (:require [delve.fs :as fs]
            [delve.ui :as ui]
            [lanterna.screen :as s])
  (:gen-class))

(defn- make-pane [path]
  {:path path
   :entries (fs/list-entries path)
   :selected 0
   :scroll 0})

(defn- clamp [n lo hi] (max lo (min n hi)))

(defn- fix-scroll [pane visible-rows]
  (let [{:keys [selected scroll]} pane]
    (cond
      (< selected scroll) (assoc pane :scroll selected)
      (>= selected (+ scroll visible-rows)) (assoc pane :scroll (- selected (dec visible-rows)))
      :else pane)))

(defn- move-selection [pane delta visible-rows]
  (let [max-idx  (max 0 (dec (count (:entries pane))))
        selected (clamp (+ (:selected pane) delta) 0 max-idx)]
    (-> pane (assoc :selected selected) (fix-scroll visible-rows))))

(defn- descend [pane]
  (if-let [entry (get (:entries pane) (:selected pane))]
    (if (:dir? entry) (make-pane (:path entry)) pane) ; opening a file does nothing for now
    pane))

(defn- ascend [pane]
  (make-pane (fs/parent-path (:path pane))))

(defn- other-pane-key [state] (if (= (:active state) :left) :right :left))

(defn- handle-key [state key visible-rows]
  (let [ak (:active state)]
    (case key
      :tab (assoc state :active (other-pane-key state))
      \q   (assoc state :quit? true)
      (\j :down)            (update state ak move-selection 1 visible-rows)
      (\k :up)              (update state ak move-selection -1 visible-rows)
      (\l :right :enter)    (update state ak descend)
      (\h :left :backspace) (update state ak ascend)
      state)))

(defn- draw-frame! [scr state]
  (let [[cols rows]  (s/get-size scr)
        visible-rows (- rows 2)]
    (s/clear scr)
    (doseq [{:keys [x y text opts]} (ui/render state cols rows)]
      (s/put-string scr x y text opts))
    (s/redraw scr)
    visible-rows))

(defn- run! []
  (let [scr   (s/get-screen :text)
        start (System/getProperty "user.dir")]
    (s/start scr)
    (try
      (loop [state {:left (make-pane start)
                    :right (make-pane start)
                    :active :left
                    :quit? false}]
        (let [visible-rows (draw-frame! scr state)]
          (when-not (:quit? state)
            (recur (handle-key state (s/get-key-blocking scr) visible-rows)))))
      (finally
        (s/stop scr)))))

(defn -main [& _args]
  (run!))
