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

  def _encontrar_then seccion
    # if T then T else T
    # if if .. then .. else ..
    # if T then if .. else T
    # if T then T else if ..

    seccion_condicion = seccion.slice(@if_offset - 1..-1)

    (_parentesis_fin seccion_condicion) + @if_offset
  end

  def _encontrar_else seccion
    # if T then T else T
    # if if .. then .. else ..
    # if T then if .. else T
    # if T then T else if ..

    seccion_then = seccion.slice((_encontrar_then seccion)..-1)

    (_parentesis_fin seccion_then) + (_encontrar_then seccion)
  end

  def eval
    puts "#{@current_step} -> Condicion: #{(Programa.new @condicion_text).eval}"
    @resultado
  end
end

class NoEsUnTerminoError < StandardError; end;
