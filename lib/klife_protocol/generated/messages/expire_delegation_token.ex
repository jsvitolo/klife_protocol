defmodule KlifeProtocol.Messages.ExpireDelegationToken do
  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 40
  @min_flexible_version_req 2
  @min_flexible_version_res 2

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

  defp request_schema(0), do: [hmac: :bytes, expiry_time_period_ms: :int64]
  defp request_schema(1), do: [hmac: :bytes, expiry_time_period_ms: :int64]

  defp request_schema(2),
    do: [hmac: :compact_bytes, expiry_time_period_ms: :int64, tag_buffer: {:tag_buffer, []}]

  defp response_schema(0),
    do: [error_code: :int16, expiry_timestamp_ms: :int64, throttle_time_ms: :int32]

  defp response_schema(1),
    do: [error_code: :int16, expiry_timestamp_ms: :int64, throttle_time_ms: :int32]

  defp response_schema(2),
    do: [
      error_code: :int16,
      expiry_timestamp_ms: :int64,
      throttle_time_ms: :int32,
      tag_buffer: {:tag_buffer, %{}}
    ]
end