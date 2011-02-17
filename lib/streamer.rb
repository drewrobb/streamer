module Streamer

  mattr_accessor :erroneous_call_to_proc
  mattr_accessor :first_record

  def stream_json
    self.first_record = true
    headers["Content-Type"] = "application/json"
    self.erroneous_call_to_proc = false
    self.response_body = proc { |response, output| 
      unless self.erroneous_call_to_proc
        @@output = output
        @@output.write '['
        yield(output)
        @@output.write ']'
      end
      self.erroneous_call_to_proc = true
    }
  end

  def send_record(c)
    self.first_record  ? self.first_record = false : @@output.write(',')
    @@output.write c.to_json
  end

  def stream_to(file_name)
    headers["Content-Type"] = "text/plain"
    headers["Content-disposition"] = "attachment; filename=\"#{file_name}\""
    self.erroneous_call_to_proc = false
    self.response_body = proc { |response, output|
      unless self.erroneous_call_to_proc
        yield(output)
      end
      self.erroneous_call_to_proc = true
    }
  end

end
