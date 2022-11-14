# DO NOT EDIT THIS FILE MANUALLY  
# This module is automatically generated by running mix task generate_file
# every change must be done inside the mix task directly

defmodule KlifeProtocol.Messages.FetchSnapshot do
  @moduledoc """
  Kafka protocol FetchSnapshot message

  Request versions summary:   

  Response versions summary:

  """

  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 59
  @min_flexible_version_req 0
  @min_flexible_version_res 0

  @doc """
  Content fields:

  - cluster_id: The clusterId if known, this is used to validate metadata fetches prior to broker registration (string | versions 0+)
  - replica_id: The broker ID of the follower (int32 | versions 0+)
  - max_bytes: The maximum bytes to fetch from all of the snapshots (int32 | versions 0+)
  - topics: The topics to fetch ([]TopicSnapshot | versions 0+)
      - name: The name of the topic to fetch (string | versions 0+)
      - partitions: The partitions to fetch ([]PartitionSnapshot | versions 0+)
          - partition: The partition index (int32 | versions 0+)
          - current_leader_epoch: The current leader epoch of the partition, -1 for unknown leader epoch (int32 | versions 0+)
          - snapshot_id: The snapshot endOffset and epoch to fetch (SnapshotId | versions 0+)
              - end_offset:  (int64 | versions 0+)
              - epoch:  (int32 | versions 0+)
          - position: The byte position within the snapshot to start fetching from (int64 | versions 0+)

  """
  def serialize_request(%{headers: headers, content: content}, version) do
    headers
    |> Map.put(:request_api_key, @api_key)
    |> Map.put(:request_api_version, version)
    |> Header.serialize_request(req_header_version(version))
    |> then(&Serializer.execute(content, request_schema(version), &1))
  end

  @doc """
  Content fields:

  - throttle_time_ms: The duration in milliseconds for which the request was throttled due to a quota violation, or zero if the request did not violate any quota. (int32 | versions 0+)
  - error_code: The top level response error code. (int16 | versions 0+)
  - topics: The topics to fetch. ([]TopicSnapshot | versions 0+)
      - name: The name of the topic to fetch. (string | versions 0+)
      - partitions: The partitions to fetch. ([]PartitionSnapshot | versions 0+)
          - index: The partition index. (int32 | versions 0+)
          - error_code: The error code, or 0 if there was no fetch error. (int16 | versions 0+)
          - snapshot_id: The snapshot endOffset and epoch fetched (SnapshotId | versions 0+)
              - end_offset:  (int64 | versions 0+)
              - epoch:  (int32 | versions 0+)
          - current_leader:  (LeaderIdAndEpoch | versions 0+)
              - leader_id: The ID of the current leader or -1 if the leader is unknown. (int32 | versions 0+)
              - leader_epoch: The latest known leader epoch (int32 | versions 0+)
          - size: The total size of the snapshot. (int64 | versions 0+)
          - position: The starting byte position within the snapshot included in the Bytes field. (int64 | versions 0+)
          - unaligned_records: Snapshot data in records format which may not be aligned on an offset boundary (records | versions 0+)

  """
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
      replica_id: {:int32, %{is_nullable?: false}},
      max_bytes: {:int32, %{is_nullable?: false}},
      topics:
        {{:compact_array,
          [
            name: {:compact_string, %{is_nullable?: false}},
            partitions:
              {{:compact_array,
                [
                  partition: {:int32, %{is_nullable?: false}},
                  current_leader_epoch: {:int32, %{is_nullable?: false}},
                  snapshot_id:
                    {{:object,
                      [
                        end_offset: {:int64, %{is_nullable?: false}},
                        epoch: {:int32, %{is_nullable?: false}},
                        tag_buffer: {:tag_buffer, []}
                      ]}, %{is_nullable?: false}},
                  position: {:int64, %{is_nullable?: false}},
                  tag_buffer: {:tag_buffer, []}
                ]}, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, [cluster_id: {{0, :compact_string}, %{is_nullable?: true}}]}
    ]

  defp response_schema(0),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}},
      topics:
        {{:compact_array,
          [
            name: {:compact_string, %{is_nullable?: false}},
            partitions:
              {{:compact_array,
                [
                  index: {:int32, %{is_nullable?: false}},
                  error_code: {:int16, %{is_nullable?: false}},
                  snapshot_id:
                    {{:object,
                      [
                        end_offset: {:int64, %{is_nullable?: false}},
                        epoch: {:int32, %{is_nullable?: false}},
                        tag_buffer: {:tag_buffer, %{}}
                      ]}, %{is_nullable?: false}},
                  size: {:int64, %{is_nullable?: false}},
                  position: {:int64, %{is_nullable?: false}},
                  unaligned_records: {:record_batch, %{is_nullable?: false}},
                  tag_buffer:
                    {:tag_buffer,
                     %{
                       0 =>
                         {{:current_leader,
                           {:object,
                            [
                              leader_id: {:int32, %{is_nullable?: false}},
                              leader_epoch: {:int32, %{is_nullable?: false}},
                              tag_buffer: {:tag_buffer, %{}}
                            ]}}, %{is_nullable?: false}}
                     }}
                ]}, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, %{}}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]
end