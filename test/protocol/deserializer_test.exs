defmodule KlifeProtocol.DeserializerTest do
  use ExUnit.Case

  alias KlifeProtocol.Deserializer

  test "int16" do
    assert {%{a: 31, b: 123, c: 4}, <<>>} =
             <<31::16-signed, 123::16-signed, 4::16-signed>>
             |> Deserializer.execute(
               a: {:int16, %{is_nullable?: false}},
               b: {:int16, %{is_nullable?: false}},
               c: {:int16, %{is_nullable?: false}}
             )
  end

  test "int32" do
    assert {%{a: 31, b: 123, c: 4}, <<>>} =
             <<31::32-signed, 123::32-signed, 4::32-signed>>
             |> Deserializer.execute(
               a: {:int32, %{is_nullable?: false}},
               b: {:int32, %{is_nullable?: false}},
               c: {:int32, %{is_nullable?: false}}
             )
  end

  test "string" do
    assert {%{a: "abc", b: "defgh", c: nil, d: "ij"}, <<>>} =
             (<<byte_size("abc")::16-signed>> <>
                "abc" <>
                <<byte_size("defgh")::16-signed>> <>
                "defgh" <>
                <<-1::16-signed>> <>
                <<byte_size("ij")::16-signed>> <> "ij")
             |> Deserializer.execute(
               a: {:string, %{is_nullable?: false}},
               b: {:string, %{is_nullable?: false}},
               c: {:string, %{is_nullable?: false}},
               d: {:string, %{is_nullable?: false}}
             )
  end

  test "array - simple" do
    assert {%{a: [10, 20], b: ["a", "b", "c"]}, <<>>} =
             (<<2::32-signed>> <>
                <<10::16-signed>> <>
                <<20::16-signed>> <>
                <<3::32-signed>> <>
                <<byte_size("a")::16-signed>> <>
                "a" <>
                <<byte_size("b")::16-signed>> <>
                "b" <>
                <<byte_size("c")::16-signed>> <>
                "c")
             |> Deserializer.execute(
               a: {{:array, {:int16, %{is_nullable?: false}}}, %{is_nullable?: false}},
               b: {{:array, {:string, %{is_nullable?: false}}}, %{is_nullable?: false}}
             )
  end

  test "array - nested" do
    assert {%{
              a: [%{a_a: 10, a_b: 20}, %{a_a: 30, a_b: 40}],
              b: [
                %{
                  b_a: [%{b_b: "a", b_c: 1}]
                },
                %{
                  b_a: [%{b_b: "b", b_c: 2}, %{b_b: "c", b_c: 3}]
                }
              ],
              c: nil,
              d: []
            },
            <<>>} =
             (<<2::32-signed>> <>
                <<10::16-signed>> <>
                <<20::32-signed>> <>
                <<30::16-signed>> <>
                <<40::32-signed>> <>
                <<2::32-signed>> <>
                <<1::32-signed>> <>
                <<byte_size("a")::16-signed>> <>
                "a" <>
                <<1::16-signed>> <>
                <<2::32-signed>> <>
                <<byte_size("b")::16-signed>> <>
                "b" <>
                <<2::16-signed>> <>
                <<byte_size("c")::16-signed>> <>
                "c" <>
                <<3::16-signed>> <>
                <<-1::32-signed>> <>
                <<0::32-signed>>)
             |> Deserializer.execute(
               a:
                 {{:array,
                   [a_a: {:int16, %{is_nullable?: false}}, a_b: {:int32, %{is_nullable?: false}}]},
                  %{is_nullable?: false}},
               b:
                 {{:array,
                   [
                     b_a:
                       {{:array,
                         [
                           b_b: {:string, %{is_nullable?: false}},
                           b_c: {:int16, %{is_nullable?: false}}
                         ]}, %{is_nullable?: false}}
                   ]}, %{is_nullable?: false}},
               c: {{:array, [c_a: {:int32, %{is_nullable?: false}}]}, %{is_nullable?: false}},
               d: {{:array, [d_a: {:int32, %{is_nullable?: false}}]}, %{is_nullable?: false}}
             )
  end
end
