require 'detector'


class Programa
  def initialize termino
    @termino = (TerminoDetector.new.parse termino.strip).eval
  end

  def eval
    @termino
  end
end
