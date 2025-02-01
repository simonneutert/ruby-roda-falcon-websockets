class App < Roda
  plugin :websockets

  def on_message(connection)
    Async do |task|
      message = connection.read
      task.sleep(3) # Async I/O here
      connection.write(message.to_str)
      connection.flush
      connection.close
    end
  end

  route do |r|
    r.is '' do
      r.websocket do |connection|
        on_message(connection).wait
      end
    end
  end
end
