defmodule KlifeProtocol.Messages.CreateAcls do
  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 30
  @min_flexible_version_req 2
  @min_flexible_version_res 2

  def serialize_request(%{headers: headers, content: content}, version) do
    headers
    |> Map.put(:request_api_key, @api_key)
    |> Map.put(:request_api_version, version)
    |> Header.serialize_request(req_header_version(version))
    |> then(&Serializer.execute(content, request_schema(version), &1))
  end

  def deserialize_response(data, version) do
    {headers, rest_data} = Header.deserialize_response(data, res_header_version(version))
    {content, <<>>} = Deserializer.execute(rest_data, response_schema(version))

    %{headers: headers, content: content}
  end

  defp req_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_req, do: 2, else: 1)

  defp res_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_res, do: 1, else: 0)

  defp request_schema(0),
    do: [
      creations:
        {{:array,
          [
            resource_type: {:int8, %{is_nullable?: false}},
            resource_name: {:string, %{is_nullable?: false}},
            principal: {:string, %{is_nullable?: false}},
            host: {:string, %{is_nullable?: false}},
            operation: {:int8, %{is_nullable?: false}},
            permission_type: {:int8, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(1),
    do: [
      creations:
        {{:array,
          [
            resource_type: {:int8, %{is_nullable?: false}},
            resource_name: {:string, %{is_nullable?: false}},
            resource_pattern_type: {:int8, %{is_nullable?: false}},
            principal: {:string, %{is_nullable?: false}},
            host: {:string, %{is_nullable?: false}},
            operation: {:int8, %{is_nullable?: false}},
            permission_type: {:int8, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(2),
    do: [
      creations:
        {{:compact_array,
          [
            resource_type: {:int8, %{is_nullable?: false}},
            resource_name: {:compact_string, %{is_nullable?: false}},
            resource_pattern_type: {:int8, %{is_nullable?: false}},
            principal: {:compact_string, %{is_nullable?: false}},
            host: {:compact_string, %{is_nullable?: false}},
            operation: {:int8, %{is_nullable?: false}},
            permission_type: {:int8, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp request_schema(3),
    do: [
      creations:
        {{:compact_array,
          [
            resource_type: {:int8, %{is_nullable?: false}},
            resource_name: {:compact_string, %{is_nullable?: false}},
            resource_pattern_type: {:int8, %{is_nullable?: false}},
            principal: {:compact_string, %{is_nullable?: false}},
            host: {:compact_string, %{is_nullable?: false}},
            operation: {:int8, %{is_nullable?: false}},
            permission_type: {:int8, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp response_schema(0),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      results:
        {{:array,
          [
            error_code: {:int16, %{is_nullable?: false}},
            error_message: {:string, %{is_nullable?: true}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(1),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      results:
        {{:array,
          [
            error_code: {:int16, %{is_nullable?: false}},
            error_message: {:string, %{is_nullable?: true}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(2),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      results:
        {{:compact_array,
          [
            error_code: {:int16, %{is_nullable?: false}},
            error_message: {:compact_string, %{is_nullable?: true}},
            tag_buffer: {:tag_buffer, %{}}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]

  defp response_schema(3),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      results:
        {{:compact_array,
          [
            error_code: {:int16, %{is_nullable?: false}},
            error_message: {:compact_string, %{is_nullable?: true}},
            tag_buffer: {:tag_buffer, %{}}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]
end