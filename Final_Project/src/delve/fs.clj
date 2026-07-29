(ns delve.fs
  (:require [clojure.string :as str])
  (:import [java.io File]))

(defn list-entries
  "Returns a sorted vector of {:name :dir? :path} maps for a directory.
   Directories sort first, then alphabetically (case-insensitive)."
  [path]
  (let [f     (File. ^String path)
        files (or (.listFiles f) (make-array File 0))]
    (->> files
         (map (fn [^File file]
                {:name (.getName file)
                 :dir?  (.isDirectory file)
                 :path  (.getAbsolutePath file)}))
         (sort-by (fn [{:keys [name dir?]}]
                    [(if dir? 0 1) (str/lower-case name)]))
         vec)))

(defn parent-path
  "Absolute path of the parent directory, or path itself if already at root."
  [path]
  (let [f (File. ^String path)]
    (if-let [parent (.getParentFile f)]
      (.getAbsolutePath parent)
      path)))
