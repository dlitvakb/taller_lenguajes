require 'terminos'


class TerminoDetector
  def parse termino
    if es_bool termino
      return TerminoBooleano.new termino
    elsif es_numero termino
      return TerminoNumerico.new termino
    elsif es_if termino
      return TerminoIf.new termino
    else
      raise NoEsUnTerminoError.new, "#{termino}"
    end
  end

  def es_bool termino
    ['true', 'false'].include? termino
  end

  def es_if termino
    /if \([\(|\w|\)]+\) then \([\(|\w|\)]+\) else \([\(|\w|\)]+\)/.match termino
  end

  def es_numero termino
    match = /[0-9]+/.match termino
    match.to_a[0].size == termino.size unless match.nil?
  end
end
