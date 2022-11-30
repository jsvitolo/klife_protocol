defmodule KlifeProtocol.SerializerTest do
  use ExUnit.Case

  alias KlifeProtocol.Serializer

  @default_metadata %{is_nullable?: false}

  test "boolean" do
    input = %{a: true, b: false, c: true}

    schema = [
      a: {:boolean, @default_metadata},
      b: {:boolean, @default_metadata},
      c: {:boolean, @default_metadata}
    ]

    assert <<1, 0, 1>> = Serializer.execute(input, schema)
  end

  test "int8" do
    input = %{a: 31, b: 123, c: 4}

    schema = [
      a: {:int8, @default_metadata},
      b: {:int8, @default_metadata},
      c: {:int8, @default_metadata}
    ]

    assert <<31, 123, 4>> = Serializer.execute(input, schema)
  end

  test "int16" do
    input = %{a: 31, b: 123, c: 4}

    schema = [
      a: {:int16, @default_metadata},
      b: {:int16, @default_metadata},
      c: {:int16, @default_metadata}
    ]

    assert <<31::16-signed, 123::16-signed, 4::16-signed>> = Serializer.execute(input, schema)
  end

  test "int32" do
    input = %{a: 31, b: 123, c: 4}

    schema = [
      a: {:int32, @default_metadata},
      b: {:int32, @default_metadata},
      c: {:int32, @default_metadata}
    ]

    assert <<31::32-signed, 123::32-signed, 4::32-signed>> = Serializer.execute(input, schema)
  end

  test "int64" do
    input = %{a: 31, b: 123, c: 4}

    schema = [
      a: {:int64, @default_metadata},
      b: {:int64, @default_metadata},
      c: {:int64, @default_metadata}
    ]

    assert <<31::64-signed, 123::64-signed, 4::64-signed>> = Serializer.execute(input, schema)
  end

  test "string" do
    input = %{a: "abc", b: "defgh", d: "ij"}

    schema = [
      a: {:string, @default_metadata},
      b: {:string, @default_metadata},
      c: {:string, %{is_nullable?: true}},
      d: {:string, @default_metadata}
    ]

    [size_a, size_b, size_d] = [byte_size(input.a), byte_size(input.b), byte_size(input.d)]

    assert <<^size_a::16-signed>> <>
             "abc" <>
             <<^size_b::16-signed>> <>
             "defgh" <>
             <<-1::16-signed>> <>
             <<^size_d::16-signed>> <> "ij" = Serializer.execute(input, schema)
  end

  test "array - simple" do
    input = %{a: [10, 20], b: ["a", "b", "c"]}

    schema = [
      a: {{:array, :int16}, @default_metadata},
      b: {{:array, :string}, @default_metadata}
    ]

    size_a = byte_size("a")
    size_b = byte_size("b")
    size_c = byte_size("c")

    assert <<2::32-signed>> <>
             <<10::16-signed>> <>
             <<20::16-signed>> <>
             <<3::32-signed>> <>
             <<^size_a::16-signed>> <>
             "a" <>
             <<^size_b::16-signed>> <>
             "b" <>
             <<^size_c::16-signed>> <>
             "c" = Serializer.execute(input, schema)
  end

  test "array - nested" do
    input = %{
      a: [%{a_a: 10, a_b: 20}, %{a_a: 30, a_b: 40}],
      b: [
        %{
          b_a: [%{b_b: "a", b_c: 1}]
        },
        %{
          b_a: [%{b_b: "b", b_c: 2}, %{b_b: "c", b_c: 3}]
        }
      ],
      d: []
    }

    schema = [
      a:
        {{:array, [a_a: {:int16, @default_metadata}, a_b: {:int32, @default_metadata}]},
         @default_metadata},
      b:
        {{:array,
          [
            b_a:
              {{:array,
                [
                  b_b: {:string, @default_metadata},
                  b_c: {:int16, @default_metadata}
                ]}, @default_metadata}
          ]}, @default_metadata},
      c: {{:array, [c_a: {:int16, @default_metadata}]}, %{is_nullable?: true}},
      d: {{:array, [d_a: {:int16, @default_metadata}]}, @default_metadata}
    ]

    size_a = byte_size("a")
    size_b = byte_size("b")
    size_c = byte_size("c")

    assert <<2::32-signed>> <>
             <<10::16-signed>> <>
             <<20::32-signed>> <>
             <<30::16-signed>> <>
             <<40::32-signed>> <>
             <<2::32-signed>> <>
             <<1::32-signed>> <>
             <<^size_a::16-signed>> <>
             "a" <>
             <<1::16-signed>> <>
             <<2::32-signed>> <>
             <<^size_b::16-signed>> <>
             "b" <>
             <<2::16-signed>> <>
             <<^size_c::16-signed>> <>
             "c" <>
             <<3::16-signed>> <>
             <<-1::32-signed>> <>
             <<0::32-signed>> = Serializer.execute(input, schema)
  end

  test "compact_bytes" do
    input = %{a: <<1, 2, 3>>, b: nil, c: <<7, 8, 9, 10>>}

    schema = [
      a: {:compact_bytes, @default_metadata},
      b: {:compact_bytes, %{is_nullable?: true}},
      c: {:compact_bytes, @default_metadata}
    ]

    assert <<4, 1, 2, 3, 0, 5, 7, 8, 9, 10>> = Serializer.execute(input, schema)
  end

  test "compact_string" do
    input = %{a: "aaa", b: nil, c: "abcabcabc"}

    schema = [
      a: {:compact_string, @default_metadata},
      b: {:compact_string, %{is_nullable?: true}},
      c: {:compact_string, @default_metadata}
    ]

    assert <<4, "aaa", 0, 10, "abcabcabc">> = Serializer.execute(input, schema)
  end

  test "compact_array - simple" do
    input = %{a: [10, 20], b: ["a", "b", "c"], c: nil}

    schema = [
      a: {{:compact_array, :int16}, @default_metadata},
      b: {{:compact_array, :compact_string}, @default_metadata},
      c: {{:compact_array, :string}, %{is_nullable?: true}}
    ]

    assert <<3, 10::16-signed, 20::16-signed>> <>
             <<4, 2, "a", 2, "b", 2, "c">> <>
             <<0>> = Serializer.execute(input, schema)
  end

  test "compact_array - nested" do
    input = %{
      a: [[10], [20, 30]],
      b: [%{b_1: ["a", "bb", "ccc"]}, %{b_1: ["d", "ee"]}]
    }

    schema = [
      a: {{:compact_array, {:compact_array, :int16}}, @default_metadata},
      b:
        {{:compact_array,
          [
            b_1: {{:compact_array, :compact_string}, @default_metadata}
          ]}, @default_metadata}
    ]

    assert <<3, 2, 10::16-signed, 3, 20::16-signed, 30::16-signed>> <>
             <<3, 4, 2, "a", 3, "bb", 4, "ccc", 3, 2, "d", 3, "ee">> =
             Serializer.execute(input, schema)
  end

  test "unsigned_varint" do
    input = %{a: 10, b: 120, c: 300}

    schema = [
      a: {:unsigned_varint, @default_metadata},
      b: {:unsigned_varint, @default_metadata},
      c: {:unsigned_varint, @default_metadata}
    ]

    assert <<10, 120, 172, 2>> = Serializer.execute(input, schema)
  end

  test "varint" do
    input = %{a: -10, b: -120, c: -300}

    schema = [
      a: {:varint, @default_metadata},
      b: {:varint, @default_metadata},
      c: {:varint, @default_metadata}
    ]

    assert <<19, 239, 1, 215, 4>> = Serializer.execute(input, schema)
  end

  test "tag_buffer" do
    input = %{a: "aaa", c: 123}

    schema = [
      tag_buffer:
        {:tag_buffer,
         [
           a: {{0, :compact_string}, @default_metadata},
           b: {{1, :int16}, @default_metadata},
           c: {{2, :int16}, @default_metadata}
         ]}
    ]

    assert <<2, 0, 5, 4, "aaa", 2, 3, 123::16-signed>> = Serializer.execute(input, schema)
  end

  test "empty tag_buffer" do
    input = %{}

    schema = [tag_buffer: {:tag_buffer, []}]

    assert <<0>> = Serializer.execute(input, schema)
  end

  test "raise not null exception with key" do
    input = %{a: true, b: nil}

    schema = [
      a: {:boolean, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, [b: {{0, :string}, %{is_nullable?: false}}]}
    ]

    assert_raise RuntimeError,
                 """
                 Serialization error:

                 field: {:b, {:string, %{is_nullable?: false}}}

                 reason: field is not nullable
                 """,
                 fn -> Serializer.execute(input, schema) end
  end

  test "record_bytes" do
    input = %{
      a: "some_bytes",
      b: nil,
      c: "much_more_bytes"
    }

    schema = [
      a: {:record_bytes, @default_metadata},
      b: {:record_bytes, %{is_nullable?: true}},
      c: {:record_bytes, @default_metadata}
    ]

    a_length = Serializer.execute(byte_size(input.a), :varint)
    b_length = Serializer.execute(-1, :varint)
    c_length = Serializer.execute(byte_size(input.c), :varint)

    assert <<
             a_length <>
               "some_bytes" <>
               b_length <>
               c_length <>
               "much_more_bytes"
           >> == Serializer.execute(input, schema)
  end

  test "record_headers" do
    input = %{
      a: [
        %{a_1: "some_bytes", a_2: "some_other_bytes"},
        %{a_1: "crazy_bytes", a_2: "something"}
      ]
    }

    schema = [
      a: {
        {:record_headers,
         [
           a_1: {:record_bytes, @default_metadata},
           a_2: {:record_bytes, @default_metadata}
         ]},
        @default_metadata
      }
    ]

    len_array = Serializer.execute(length(input.a), :varint)
    a_1_1_len = Serializer.execute(byte_size("some_bytes"), :varint)
    a_2_1_len = Serializer.execute(byte_size("some_other_bytes"), :varint)
    a_1_2_len = Serializer.execute(byte_size("crazy_bytes"), :varint)
    a_2_2_len = Serializer.execute(byte_size("something"), :varint)

    assert <<
             len_array <>
               a_1_1_len <>
               "some_bytes" <>
               a_2_1_len <>
               "some_other_bytes" <>
               a_1_2_len <>
               "crazy_bytes" <>
               a_2_2_len <> "something"
           >> ==
             Serializer.execute(input, schema)
  end
end
