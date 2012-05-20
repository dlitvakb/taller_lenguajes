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
    @if_offset = 'if ('.size
    @then_offset = ') then ('.size
    @else_offset = ') else ('.size

    posicion_then = _encontrar_then termino_if
    posicion_else = _encontrar_else termino_if

    @condicion_text = termino_if.slice(@if_offset..posicion_then - 2)
    if (Programa.new @condicion_text).eval
      @resultado = (Programa.new termino_if.slice((posicion_then + @then_offset - 1)..(posicion_else - 1))).eval
    else
      @resultado = (Programa.new termino_if.slice(posicion_else + @else_offset..-2)).eval
    end
  end

  def _parentesis_fin seccion
    contador = 0
    pos = 0
    seccion.each_char { |e|
      if ["(",")"].include? e
        contador += 1 if e == "("
        contador -= 1 if e == ")"
        return pos if contador == 0
      end
      pos += 1
    }
  end

  def _encontrar_seccion seccion, offset_inicial, desvio_inicial=0
    seccion_anterior = seccion.slice(offset_inicial - desvio_inicial..-1)

    (_parentesis_fin seccion_anterior) + offset_inicial
  end

  def _encontrar_then seccion
    _encontrar_seccion seccion, @if_offset, 1
  end

  def _encontrar_else seccion
    _encontrar_seccion seccion, (_encontrar_then seccion)
  end

  def eval
    puts "#{@current_step} -> Condicion: #{(Programa.new @condicion_text).eval}"
    @resultado
  end
end

class NoEsUnTerminoError < StandardError; end;
