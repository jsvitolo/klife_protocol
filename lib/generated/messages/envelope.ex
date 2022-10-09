defmodule KlifeProtocol.Messages.Envelope do
  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 58
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
      request_data: {:compact_bytes, %{is_nullable?: false}},
      request_principal: {:compact_bytes, %{is_nullable?: true}},
      client_host_address: {:compact_bytes, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp response_schema(0),
    do: [
      response_data: {:compact_bytes, %{is_nullable?: true}},
      error_code: {:int16, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]
end