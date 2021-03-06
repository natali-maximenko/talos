defmodule Talos.Types.FloatTypeTest do
  use ExUnit.Case
  alias Talos.Types.FloatType
  doctest FloatType

  test "#valid? - with additional params" do
    assert true == FloatType.valid?(%FloatType{allow_nil: true}, nil)
    assert true == FloatType.valid?(%FloatType{lt: 3}, 1.0)
    assert false == FloatType.valid?(%FloatType{lt: 0}, 1.0)
    assert false == FloatType.valid?(%FloatType{lt: 0.0}, 0.0)

    assert true == FloatType.valid?(%FloatType{gt: 2}, 10.0)
    assert false == FloatType.valid?(%FloatType{gt: 2}, 0.0)
    assert false == FloatType.valid?(%FloatType{gt: 2}, 2.0)

    assert true == FloatType.valid?(%FloatType{gteq: 0.0}, 0.0)
    assert true == FloatType.valid?(%FloatType{gteq: 0}, 10.0)
    assert false == FloatType.valid?(%FloatType{gteq: 0}, -10.0)

    assert false == FloatType.valid?(%FloatType{lteq: 42}, 100.0)
    assert true == FloatType.valid?(%FloatType{lteq: 42}, 42.0)
    assert true == FloatType.valid?(%FloatType{lteq: 42}, 0.0)
  end

  test "#valid? with allow_blank" do
    assert true == FloatType.valid?(%FloatType{allow_blank: true}, 0.0)
  end

  test "#valid? - default params" do
    assert true == FloatType.valid?(%FloatType{}, 1.0)
    assert false == FloatType.valid?(%FloatType{}, 1)
    assert false == FloatType.valid?(%FloatType{}, "String")
    assert false == FloatType.valid?(%FloatType{}, %{})
    assert false == FloatType.valid?(%FloatType{}, nil)
    assert false == FloatType.valid?(%FloatType{}, DateTime.utc_now())
    assert false == FloatType.valid?(%FloatType{}, [])
  end

  test "#errors - default params" do
    assert [] == FloatType.errors(%FloatType{}, 1.0)
    assert ["1", _error_message] = FloatType.errors(%FloatType{}, 1)
    assert [_string, _error_message] = FloatType.errors(%FloatType{}, "String")
    assert [_map, _error_message] = FloatType.errors(%FloatType{}, %{})
    assert [_nil, _error_message] = FloatType.errors(%FloatType{}, nil)
    assert [_datetime, _error_messages] = FloatType.errors(%FloatType{}, DateTime.utc_now())
    assert [_list, _error_message] = FloatType.errors(%FloatType{}, [])
  end
end
