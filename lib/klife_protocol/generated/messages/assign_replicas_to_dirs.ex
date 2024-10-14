# DO NOT EDIT THIS FILE MANUALLY  
# This module is automatically generated by running mix task generate_file
# every change must be done inside the mix task directly

defmodule KlifeProtocol.Messages.AssignReplicasToDirs do
  @moduledoc """
  Kafka protocol AssignReplicasToDirs message

  Request versions summary:   

  Response versions summary:

  """

  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 73
  @min_flexible_version_req 0
  @min_flexible_version_res 0

  @doc """
  Receives a map and serialize it to kafka wire format of the given version.

  Input content fields:
  - broker_id: The ID of the requesting broker (int32 | versions 0+)
  - broker_epoch: The epoch of the requesting broker (int64 | versions 0+)
  - directories:  ([]DirectoryData | versions 0+)
      - id: The ID of the directory (uuid | versions 0+)
      - topics:  ([]TopicData | versions 0+)
          - topic_id: The ID of the assigned topic (uuid | versions 0+)
          - partitions:  ([]PartitionData | versions 0+)
              - partition_index: The partition index (int32 | versions 0+)

  """
  def serialize_request(%{headers: headers, content: content}, version) do
    headers
    |> Map.put(:request_api_key, @api_key)
    |> Map.put(:request_api_version, version)
    |> Header.serialize_request(req_header_version(version))
    |> then(&Serializer.execute(content, request_schema(version), &1))
  end

  @doc """
  Receive a binary in the kafka wire format and deserialize it into a map.

  Response content fields:

  - throttle_time_ms: The duration in milliseconds for which the request was throttled due to a quota violation, or zero if the request did not violate any quota. (int32 | versions 0+)
  - error_code: The top level response error code (int16 | versions 0+)
  - directories:  ([]DirectoryData | versions 0+)
      - id: The ID of the directory (uuid | versions 0+)
      - topics:  ([]TopicData | versions 0+)
          - topic_id: The ID of the assigned topic (uuid | versions 0+)
          - partitions:  ([]PartitionData | versions 0+)
              - partition_index: The partition index (int32 | versions 0+)
              - error_code: The partition level error code (int16 | versions 0+)

  """
  def deserialize_response(data, version, with_header? \\ true)

  def deserialize_response(data, version, true) do
    {:ok, {headers, rest_data}} = Header.deserialize_response(data, res_header_version(version))

    case Deserializer.execute(rest_data, response_schema(version)) do
      {:ok, {content, <<>>}} ->
        {:ok, %{headers: headers, content: content}}

      {:error, _reason} = err ->
        err
    end
  end

  def deserialize_response(data, version, false) do
    case Deserializer.execute(data, response_schema(version)) do
      {:ok, {content, <<>>}} ->
        {:ok, %{content: content}}

      {:error, _reason} = err ->
        err
    end
  end

  @doc """
  Returns the message api key number.
  """
  def api_key(), do: @api_key

  @doc """
  Returns the current max supported version of this message.
  """
  def max_supported_version(), do: 0

  @doc """
  Returns the current min supported version of this message.
  """
  def min_supported_version(), do: 0

  defp req_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_req, do: 2, else: 1)

  defp res_header_version(msg_version),
    do: if(msg_version >= @min_flexible_version_res, do: 1, else: 0)

  defp request_schema(0),
    do: [
      broker_id: {:int32, %{is_nullable?: false}},
      broker_epoch: {:int64, %{is_nullable?: false}},
      directories:
        {{:compact_array,
          [
            id: {:uuid, %{is_nullable?: false}},
            topics:
              {{:compact_array,
                [
                  topic_id: {:uuid, %{is_nullable?: false}},
                  partitions:
                    {{:compact_array,
                      [
                        partition_index: {:int32, %{is_nullable?: false}},
                        tag_buffer: {:tag_buffer, []}
                      ]}, %{is_nullable?: false}},
                  tag_buffer: {:tag_buffer, []}
                ]}, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp request_schema(unkown_version),
    do: raise("Unknown version #{unkown_version} for message AssignReplicasToDirs")

  defp response_schema(0),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}},
      directories:
        {{:compact_array,
          [
            id: {:uuid, %{is_nullable?: false}},
            topics:
              {{:compact_array,
                [
                  topic_id: {:uuid, %{is_nullable?: false}},
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
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]

  defp response_schema(unkown_version),
    do: raise("Unknown version #{unkown_version} for message AssignReplicasToDirs")
end