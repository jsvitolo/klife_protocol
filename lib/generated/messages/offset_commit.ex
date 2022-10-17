defmodule KlifeProtocol.Messages.OffsetCommit do
  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 8
  @min_flexible_version_req 8
  @min_flexible_version_res 8

  def serialize_request(input, version) do
    input
    |> Map.put(:request_api_key, @api_key)
    |> Map.put(:request_api_version, version)
    |> Header.serialize_request(req_header_version(version))
    |> then(&Serializer.execute(input, request_schema(version), &1))
  end

  def deserialize_response(data, version) do
    with {headers, rest_data} <- Header.deserialize_response(data, res_header_version(version)),
         {content, <<>>} <- Deserializer.execute(rest_data, response_schema(version)) do
      %{headers: headers, content: content}
    end
  end

  defp req_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_req, do: 2, else: 1)

  defp res_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_res, do: 1, else: 0)

  defp request_schema(0),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  committed_metadata: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(1),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      generation_id: {:int32, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  commit_timestamp: {:int64, %{is_nullable?: false}},
                  committed_metadata: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(2),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      generation_id: {:int32, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}},
      retention_time_ms: {:int64, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  committed_metadata: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(3),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      generation_id: {:int32, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}},
      retention_time_ms: {:int64, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  committed_metadata: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(4),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      generation_id: {:int32, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}},
      retention_time_ms: {:int64, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  committed_metadata: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(5),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      generation_id: {:int32, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  committed_metadata: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(6),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      generation_id: {:int32, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  committed_leader_epoch: {:int32, %{is_nullable?: false}},
                  committed_metadata: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(7),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      generation_id: {:int32, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}},
      group_instance_id: {:string, %{is_nullable?: true}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  committed_leader_epoch: {:int32, %{is_nullable?: false}},
                  committed_metadata: {:string, %{is_nullable?: true}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(8),
    do: [
      group_id: {:compact_string, %{is_nullable?: false}},
      generation_id: {:int32, %{is_nullable?: false}},
      member_id: {:compact_string, %{is_nullable?: false}},
      group_instance_id: {:compact_string, %{is_nullable?: true}},
      topics:
        {{:compact_array,
          [
            name: {:compact_string, %{is_nullable?: false}},
            partitions:
              {{:compact_array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  committed_offset: {:int64, %{is_nullable?: false}},
                  committed_leader_epoch: {:int32, %{is_nullable?: false}},
                  committed_metadata: {:compact_string, %{is_nullable?: true}},
                  tag_buffer: {:tag_buffer, []}
                ]}, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp response_schema(0),
    do: [
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(1),
    do: [
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(2),
    do: [
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(3),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(4),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(5),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(6),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(7),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      topics:
        {{:array,
          [
            name: {:string, %{is_nullable?: false}},
            partitions:
              {{:array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(8),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      topics:
        {{:compact_array,
          [
            name: {:compact_string, %{is_nullable?: false}},
            partitions:
              {{:compact_array,
                [
                  partition_index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}},
                  tag_buffer: {:tag_buffer, %{}}
                ]}, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, %{}}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]
end