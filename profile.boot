
(require '[clojure.java.io :as io]
         '[clojure.walk :as walk]
         '[clojure.string :as str])

(deftask huobi []
  (merge-env!
   :mirrors
   {"maven-central" {:name "Internal nexus"
                     :url  "http://nexus.huobidev.com:8081/repository/maven-public/"}
    "clojars"       {:name         "Internal nexus"
                     :url          "http://nexus.huobidev.com:8081/repository/clojars/"
                     :repo-manager true}}
   :repositories
   [["snapshots" "http://nexus.huobidev.com:8081/repository/maven-snapshots/"]
    ["releases"  "http://nexus.huobidev.com:8081/repository/maven-releases/"]])
  identity)

(defn- unquote-project
  "Inside defproject forms, unquoting (~) allows for arbitrary evaluation."
  [args]
  (walk/walk (fn [item]
               (cond (and (seq? item) (= `unquote (first item))) (second item)
                 ;; needed if we want fn literals preserved
                 (or (seq? item) (symbol? item)) (list 'quote item)
                 :else (let [result (unquote-project item)]
                         ;; clojure.walk strips metadata
                         (if-let [m (meta item)]
                           (with-meta result m)
                           result))))
             identity
             args))

(defmacro defproject
  "The project.clj file must either def a project map or call this macro.
  See `lein help sample` to see what arguments it accepts."
  [project-name version & args]
  `(let [m# ~(unquote-project (apply array-map args))]
     (def ~'project
       m#)))

(def NS (ns-name *ns*))

(def head (pr-str `(ns lein.project
                     (:refer ~NS :only [~'defproject]))))

(deftask from-lein []
  (->> (slurp "project.clj")
       (str head "\n")
       (load-string))
  (let [{:as   project
         :keys [mirrors repositories dependencies main]}
        (var-get (resolve 'lein.project/project))]
    (merge-env!
     :mirrors      (clojure.set/rename-keys
                    mirrors
                    {"central" "maven-central"})
     :repositories repositories
     :source-paths (set (concat (:source-paths project ["src"])
                                ))
     :resource-paths (set (concat (:resource-paths project ["resources"])
                                  (:source-paths project ["src"])))
     :dependencies dependencies
     :lein/main    main))
  identity)

(deftask test []
  (merge-env!
   :dependencies '[[adzerk/boot-test "RELEASE"]]
   :source-paths (get-env :test-paths #{"test"}))
  (require 'adzerk.boot-test)
  (apply (resolve 'adzerk.boot-test/test) *args*))

(deftask run []
  (let [args        (rest *args*)
        method      (or (first *args*)
                        (str (get-env :lein/main)))
        [ns method] (map symbol (str/split method #"/"))
        method      (or method '-main)]
    (require ns)
    (apply (ns-resolve ns method) args))
  identity)

(deftask cider "CIDER profile"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         concat '[[cider/cider-nrepl "0.16.0"]
                  ;[refactor-nrepl "2.3.1"]
                  [org.clojure/tools.namespace "0.2.11"]])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         concat '[cider.nrepl/cider-middleware
                  ;refactor-nrepl.middleware/wrap-refactor
                  ])
  identity)

(deftask light "Light Table InstaREPL support"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         conj '[lein-light-nrepl "0.3.0"])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         conj 'lighttable.nrepl.handler/lighttable-ops))
