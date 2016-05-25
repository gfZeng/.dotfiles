(deftask cider "CIDER profile"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         concat '[[org.clojure/tools.nrepl "0.2.12"]
                  [cider/cider-nrepl "0.13.0-SNAPSHOT"]
                  [refactor-nrepl "2.3.0-SNAPSHOT"]
                  [alembic "0.3.2"]])
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
