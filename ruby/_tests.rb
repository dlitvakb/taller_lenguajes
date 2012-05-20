require 'test/unit'
require 'programa'

class TestPrograma < Test::Unit::TestCase
  def test_ejecutar_programa
    assert 1 == (Programa.new "1").eval
  end
end

class TestTerminoDetector < Test::Unit::TestCase
  def test_booleanos
    assert (TerminoDetector.new.es_bool "true")
    assert (TerminoDetector.new.es_bool "false")

    assert (!TerminoDetector.new.es_bool "pepe")
  end

  def test_numeros
    assert (TerminoDetector.new.es_numero "1")
    assert (!TerminoDetector.new.es_numero "pepe")
  end

  def test_if
    assert (TerminoDetector.new.es_if "if (1) then (1) else (1)")
    assert (!TerminoDetector.new.es_if "fruta")
  end
end

class TestTerminos < Test::Unit::TestCase
  def test_termino_booleano
    assert (TerminoBooleano.new "true").eval
    assert !(TerminoBooleano.new "false").eval
  end

  def test_termino_numerico
    assert 4 == (TerminoNumerico.new "4").eval
  end

  def test_termino_if
    assert (TerminoIf.new "if (true) then (true) else (false)").eval
    assert !(TerminoIf.new "if (false) then (true) else (false)").eval
  end

  def test_if_anidados
    assert 6 == (TerminoIf.new "if (if (true) then (false) else (true)) then (123) else (if (1) then (6) else (false))").eval
  end
end
