require "net/http"

Net::HTTP.get(URI('http://192.168.2.123:4567/socket/lamp/on'))