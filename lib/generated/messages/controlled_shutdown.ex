defmodule KlifeProtocol.Messages.ControlledShutdown do
  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 7
  @min_flexible_version_req 3
  @min_flexible_version_res 3

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

  defp req_header_version(msg_version) do
    if msg_version in [0],
      do: 0,
      else: if(msg_version >= @min_flexible_version_req, do: 2, else: 1)
  end

  defp res_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_res, do: 1, else: 0)

  defp request_schema(0), do: [broker_id: {:int32, %{is_nullable?: false}}]
  defp request_schema(1), do: [broker_id: {:int32, %{is_nullable?: false}}]

  defp request_schema(2),
    do: [
      broker_id: {:int32, %{is_nullable?: false}},
      broker_epoch: {:int64, %{is_nullable?: false}}
    ]

  defp request_schema(3),
    do: [
      broker_id: {:int32, %{is_nullable?: false}},
      broker_epoch: {:int64, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp response_schema(0),
    do: [
      error_code: {:int16, %{is_nullable?: false}},
      remaining_partitions:
        {{:array,
          [
            topic_name: {:string, %{is_nullable?: false}},
            partition_index: {:int32, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(1),
    do: [
      error_code: {:int16, %{is_nullable?: false}},
      remaining_partitions:
        {{:array,
          [
            topic_name: {:string, %{is_nullable?: false}},
            partition_index: {:int32, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(2),
    do: [
      error_code: {:int16, %{is_nullable?: false}},
      remaining_partitions:
        {{:array,
          [
            topic_name: {:string, %{is_nullable?: false}},
            partition_index: {:int32, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(3),
    do: [
      error_code: {:int16, %{is_nullable?: false}},
      remaining_partitions:
        {{:compact_array,
          [
            topic_name: {:compact_string, %{is_nullable?: false}},
            partition_index: {:int32, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, %{}}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]
end