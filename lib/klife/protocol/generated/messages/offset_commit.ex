defmodule Klife.Protocol.Messages.OffsetCommit do
  alias Klife.Protocol.Deserializer
  alias Klife.Protocol.Serializer
  alias Klife.Protocol.Header

  def get_api_key(), do: 8

  def request_schema(0),
    do: [
      group_id: :string,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, committed_offset: :int64, committed_metadata: :string]}
         ]}
    ]

  def request_schema(1),
    do: [
      group_id: :string,
      generation_id: :int32,
      member_id: :string,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                committed_offset: :int64,
                commit_timestamp: :int64,
                committed_metadata: :string
              ]}
         ]}
    ]

  def request_schema(2),
    do: [
      group_id: :string,
      generation_id: :int32,
      member_id: :string,
      retention_time_ms: :int64,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, committed_offset: :int64, committed_metadata: :string]}
         ]}
    ]

  def request_schema(3),
    do: [
      group_id: :string,
      generation_id: :int32,
      member_id: :string,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, committed_offset: :int64, committed_metadata: :string]}
         ]}
    ]

  def request_schema(4),
    do: [
      group_id: :string,
      generation_id: :int32,
      member_id: :string,
      retention_time_ms: :int64,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, committed_offset: :int64, committed_metadata: :string]}
         ]}
    ]

  def request_schema(5),
    do: [
      group_id: :string,
      generation_id: :int32,
      member_id: :string,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, committed_offset: :int64, committed_metadata: :string]}
         ]}
    ]

  def request_schema(6),
    do: [
      group_id: :string,
      generation_id: :int32,
      member_id: :string,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                committed_offset: :int64,
                committed_leader_epoch: :int32,
                committed_metadata: :string
              ]}
         ]}
    ]

  def request_schema(7),
    do: [
      group_id: :string,
      generation_id: :int32,
      member_id: :string,
      group_instance_id: :string,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                committed_offset: :int64,
                committed_leader_epoch: :int32,
                committed_metadata: :string
              ]}
         ]}
    ]

  def request_schema(8),
    do: [
      group_id: :string,
      generation_id: :int32,
      member_id: :string,
      group_instance_id: :string,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                committed_offset: :int64,
                committed_leader_epoch: :int32,
                committed_metadata: :string,
                tag_buffer: %{}
              ]},
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]

  def response_schema(0),
    do: [
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, error_code: :int16]}]}
    ]

  def response_schema(1),
    do: [
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, error_code: :int16]}]}
    ]

  def response_schema(2),
    do: [
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, error_code: :int16]}]}
    ]

  def response_schema(3),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, error_code: :int16]}]}
    ]

  def response_schema(4),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, error_code: :int16]}]}
    ]

  def response_schema(5),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, error_code: :int16]}]}
    ]

  def response_schema(6),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, error_code: :int16]}]}
    ]

  def response_schema(7),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, error_code: :int16]}]}
    ]

  def response_schema(8),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [
           name: :string,
           partitions: {:array, [partition_index: :int32, error_code: :int16, tag_buffer: %{}]},
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]
end