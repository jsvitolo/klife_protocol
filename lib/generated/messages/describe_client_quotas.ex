defmodule KlifeProtocol.Messages.DescribeClientQuotas do
  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 48
  @min_flexible_version_req 1
  @min_flexible_version_res 1

  def deserialize_response(data, version) do
    with {headers, rest_data} <- Header.deserialize_response(data, res_header_version(version)),
         {content, _} <- Deserializer.execute(rest_data, response_schema(version)) do
      %{headers: headers, content: content}
    end
  end

  def serialize_request(input, version) do
    input
    |> Map.put(:request_api_key, @api_key)
    |> Map.put(:request_api_version, version)
    |> Header.serialize_request(req_header_version(version))
    |> then(&Serializer.execute(input, request_schema(version), &1))
  end

  defp req_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_req, do: 2, else: 1)

  defp res_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_res, do: 1, else: 0)

  defp request_schema(0),
    do: [
      components:
        {{:array,
          [
            entity_type: {:string, %{is_nullable?: false}},
            match_type: {:int8, %{is_nullable?: false}},
            match: {:string, %{is_nullable?: true}}
          ]}, %{is_nullable?: false}},
      strict: {:boolean, %{is_nullable?: false}}
    ]

  defp request_schema(1),
    do: [
      components:
        {{:compact_array,
          [
            entity_type: {:compact_string, %{is_nullable?: false}},
            match_type: {:int8, %{is_nullable?: false}},
            match: {:compact_string, %{is_nullable?: true}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      strict: {:boolean, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp response_schema(0),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}},
      error_message: {:string, %{is_nullable?: true}},
      entries:
        {{:array,
          [
            entity:
              {{:array,
                [
                  entity_type: {:string, %{is_nullable?: false}},
                  entity_name: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}},
            values:
              {{:array,
                [
                  key: {:string, %{is_nullable?: false}},
                  value: {:float64, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: true}}
    ]

  defp response_schema(1),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}},
      error_message: {:compact_string, %{is_nullable?: true}},
      entries:
        {{:compact_array,
          [
            entity:
              {{:compact_array,
                [
                  entity_type: {:compact_string, %{is_nullable?: false}},
                  entity_name: {:compact_string, %{is_nullable?: true}},
                  tag_buffer: {:tag_buffer, %{}}
                ]}, %{is_nullable?: false}},
            values:
              {{:compact_array,
                [
                  key: {:compact_string, %{is_nullable?: false}},
                  value: {:float64, %{is_nullable?: false}},
                  tag_buffer: {:tag_buffer, %{}}
                ]}, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, %{}}
          ]}, %{is_nullable?: true}},
      tag_buffer: {:tag_buffer, %{}}
    ]
end