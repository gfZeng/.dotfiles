
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


(deftask testing []
  (merge-env! :source-paths #{"test"})
  identity)

(deftask cider "CIDER profile"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         concat '[[cider/cider-nrepl "0.14.0"]
                  [refactor-nrepl "2.2.0"]
                  [org.clojure/tools.namespace "0.2.11"]])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         concat '[cider.nrepl/cider-middleware
                  refactor-nrepl.middleware/wrap-refactor])
  identity)

(deftask light "Light Table InstaREPL support"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         conj '[lein-light-nrepl "0.3.0"])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         conj 'lighttable.nrepl.handler/lighttable-ops))
