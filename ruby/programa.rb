require 'pry'

class Termino
  def initialize termino
    termino = termino.strip
    if ['true', 'false'].include? termino
      @termino = (TerminoBooleano.new termino).eval
    elsif es_if termino
      @termino = (TerminoIf.new termino).eval
    elsif es_numero termino
      @termino = (TerminoNumerico.new termino).eval
    else
      raise NoEsUnTerminoError.new "#{termino}"
    end
  end

  def es_if termino
    /if \w+ then \w+ else \w+/.match termino
  end

  def es_numero termino
    /\d+/.match termino
  end

  def eval
    @termino
  end
end

class TerminoBooleano
  def initialize termino
    posibles = {"true" => true, "false" => false}
    @termino = posibles[termino]
  end

  def eval
    @termino
  end
end

class TerminoNumerico
  def initialize termino
    @termino = termino.to_i
  end

  def eval
    @termino
  end
end

class TerminoIf
  def initialize termino_if
    if_offset = 3
    then_offset = 6
    else_offset = 6

    posicion_then = termino_if.rindex(' then ')
    posicion_else = termino_if.rindex(' else ')

    @condicion = (Termino.new termino_if.slice(if_offset..posicion_then)).eval
    if @condicion
      @resultado = (Termino.new termino_if.slice((posicion_then + then_offset)..posicion_else)).eval
    else
      @resultado = (Termino.new termino_if.slice((posicion_else + else_offset).. -1)).eval
    end

    @current_step = termino_if.slice(0..if_offset - 1) + @condicion.to_s + termino_if.slice(posicion_then..-1)
  end

  def eval
    puts @current_step
    @resultado
  end
end

class NoEsUnTerminoError < StandardError; end;
