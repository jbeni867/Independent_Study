(ns delve.ui
  "Pure rendering: turns app state into a list of draw ops.
   No lanterna calls here — core.clj is the only namespace that touches
   the Screen. That keeps this testable without a real terminal.")

(defn- truncate [s width]
  (if (> (count s) width)
    (str (subs s 0 (max 0 (dec width))) "…")
    s))

(defn- pad [s width]
  (let [s (truncate s width)]
    (str s (apply str (repeat (max 0 (- width (count s))) " ")))))

(defn- entry-opts
  "Lanterna's :reverse style is broken in this version, so selection is
   simulated by swapping fg/bg explicitly instead."
  [entry selected?]
  (cond
    selected?     {:fg :black :bg :white}
    (:dir? entry) {:fg :cyan}
    :else         {:fg :default}))

(defn- entry-text [entry width]
  (pad (str " " (:name entry) (when (:dir? entry) "/")) width))

(defn- pane-ops [{:keys [path entries selected scroll]} x pane-height pane-width active?]
  (let [header-op  {:x x :y 0
                     :text (pad (truncate path pane-width) pane-width)
                     :opts (if active? {:fg :green} {:fg :default})}
        visible    (->> entries (drop scroll) (take pane-height))
        entry-ops  (map-indexed
                     (fn [i entry]
                       {:x x :y (inc i)
                        :text (entry-text entry pane-width)
                        :opts (entry-opts entry (= (+ scroll i) selected))})
                     visible)
        filler-ops (for [i (range (count visible) pane-height)]
                     {:x x :y (inc i) :text (pad "" pane-width) :opts {:fg :default}})]
    (cons header-op (concat entry-ops filler-ops))))

(defn render
  "cols/rows -> seq of {:x :y :text :opts} draw ops covering the full frame."
  [{:keys [left right active]} cols rows]
  (let [gap         3
        pane-width  (quot (- cols gap) 2)
        pane-height (- rows 2) ; header row + status row
        right-x     (+ pane-width gap)
        left-ops    (pane-ops left  0       pane-height pane-width (= active :left))
        right-ops   (pane-ops right right-x pane-height pane-width (= active :right))
        sep-ops     (for [row (range (inc pane-height))]
                      {:x pane-width :y row :text " │ " :opts {:fg :default}})
        status      " Tab: switch pane   h/←: up dir   l/→/Enter: open   j/k: move   q: quit"
        status-op   {:x 0 :y (inc pane-height) :text (pad status cols) :opts {:fg :default}}]
    (concat left-ops right-ops sep-ops [status-op])))
