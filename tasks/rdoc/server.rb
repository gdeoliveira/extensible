# frozen_string_literal: true

require "webrick"

namespace :rdoc do
  DOCUMENT_SERVER_PORT = 3001

  desc "Start an HTTP server for retrieving RDoc documentation files on port #{DOCUMENT_SERVER_PORT}"
  task :server do
    server = WEBrick::HTTPServer.new(DocumentRoot: "doc/", Port: DOCUMENT_SERVER_PORT)
    shutdown = proc { server.shutdown }
    %w(INT TERM).each {|signal| trap(signal, &shutdown) }
    server.start
  end
end
