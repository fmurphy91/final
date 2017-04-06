require 'singleton'
class DoctorLogger < include
  Singleton
  def initialize
    @log = File.open("doctorlog.txt", "a")
  end
  def logInformation(information)
    @log.puts(information)
    @log.flush
  end
end
