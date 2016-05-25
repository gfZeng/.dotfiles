{:user {:plugins [[cider/cider-nrepl "0.11.0-SNAPSHOT"]
                  [refactor-nrepl "2.2.0-SNAPSHOT"]
                  [lein-pprint "1.1.1"]
                  [lein-pdo "0.1.1"]]
        :dependencies [[alembic "0.3.2"]
                       [org.clojure/tools.nrepl "0.2.12"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}}}
