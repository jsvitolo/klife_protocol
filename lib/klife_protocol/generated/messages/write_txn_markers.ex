# DO NOT EDIT THIS FILE MANUALLY  
# This module is automatically generated by running mix task generate_file
# every change must be done inside the mix task directly

defmodule KlifeProtocol.Messages.WriteTxnMarkers do
  @moduledoc """
  Kafka protocol WriteTxnMarkers message

  Request versions summary:   
  - Version 1 enables flexible versions.

  Response versions summary:

  """

  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 27
  @min_flexible_version_req 1
  @min_flexible_version_res 1

  @doc """
  Receives a map and serialize it to kafka wire format of the given version.

  Input content fields:
  - markers: The transaction markers to be written. ([]WritableTxnMarker | versions 0+)
      - producer_id: The current producer ID. (int64 | versions 0+)
      - producer_epoch: The current epoch associated with the producer ID. (int16 | versions 0+)
      - transaction_result: The result of the transaction to write to the partitions (false = ABORT, true = COMMIT). (bool | versions 0+)
      - topics: Each topic that we want to write transaction marker(s) for. ([]WritableTxnMarkerTopic | versions 0+)
          - name: The topic name. (string | versions 0+)
          - partition_indexes: The indexes of the partitions to write transaction markers for. ([]int32 | versions 0+)
      - coordinator_epoch: Epoch associated with the transaction state partition hosted by this transaction coordinator (int32 | versions 0+)

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

  - markers: The results for writing makers. ([]WritableTxnMarkerResult | versions 0+)
      - producer_id: The current producer ID in use by the transactional ID. (int64 | versions 0+)
      - topics: The results by topic. ([]WritableTxnMarkerTopicResult | versions 0+)
          - name: The topic name. (string | versions 0+)
          - partitions: The results by partition. ([]WritableTxnMarkerPartitionResult | versions 0+)
              - partition_index: The partition index. (int32 | versions 0+)
              - error_code: The error code, or 0 if there was no error. (int16 | versions 0+)

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
  Returns the current max supported version of this message.
  """
  def max_supported_version(), do: 1

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
      markers:
        {{:array,
          [
            producer_id: {:int64, %{is_nullable?: false}},
            producer_epoch: {:int16, %{is_nullable?: false}},
            transaction_result: {:boolean, %{is_nullable?: false}},
            topics:
              {{:array,
                [
                  name: {:string, %{is_nullable?: false}},
                  partition_indexes: {{:array, :int32}, %{is_nullable?: false}}
                ]}, %{is_nullable?: false}},
            coordinator_epoch: {:int32, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(1),
    do: [
      markers:
        {{:compact_array,
          [
            producer_id: {:int64, %{is_nullable?: false}},
            producer_epoch: {:int16, %{is_nullable?: false}},
            transaction_result: {:boolean, %{is_nullable?: false}},
            topics:
              {{:compact_array,
                [
                  name: {:compact_string, %{is_nullable?: false}},
                  partition_indexes: {{:compact_array, :int32}, %{is_nullable?: false}},
                  tag_buffer: {:tag_buffer, []}
                ]}, %{is_nullable?: false}},
            coordinator_epoch: {:int32, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp request_schema(unkown_version),
    do: raise("Unknown version #{unkown_version} for message WriteTxnMarkers")

  defp response_schema(0),
    do: [
      markers:
        {{:array,
          [
            producer_id: {:int64, %{is_nullable?: false}},
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
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(1),
    do: [
      markers:
        {{:compact_array,
          [
            producer_id: {:int64, %{is_nullable?: false}},
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
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]

  defp response_schema(unkown_version),
    do: raise("Unknown version #{unkown_version} for message WriteTxnMarkers")
end