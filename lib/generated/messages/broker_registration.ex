defmodule KlifeProtocol.Messages.BrokerRegistration do
  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 62
  @min_flexible_version_req 0
  @min_flexible_version_res 0

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
      broker_id: {:int32, %{is_nullable?: false}},
      cluster_id: {:compact_string, %{is_nullable?: false}},
      incarnation_id: {:uuid, %{is_nullable?: false}},
      listeners:
        {{:compact_array,
          [
            name: {:compact_string, %{is_nullable?: false}},
            host: {:compact_string, %{is_nullable?: false}},
            port: {:uint16, %{is_nullable?: false}},
            security_protocol: {:int16, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      features:
        {{:compact_array,
          [
            name: {:compact_string, %{is_nullable?: false}},
            min_supported_version: {:int16, %{is_nullable?: false}},
            max_supported_version: {:int16, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      rack: {:compact_string, %{is_nullable?: true}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp response_schema(0),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}},
      broker_epoch: {:int64, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]
end