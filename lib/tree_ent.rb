require "require_all"
require "time"
require "logger"
require "fileutils"

module TreeEnt
  VERSION = "0.1"
end

require_rel "./tree_ent/*.rb"
require_rel "./tree_ent/modules/*.rb"