defmodule Klife.Protocol.Messages.ListOffsets do
  alias Klife.Protocol.Deserializer
  alias Klife.Protocol.Serializer
  alias Klife.Protocol.Header

  def get_api_key(), do: 2

  def request_schema(0),
    do: [
      replica_id: :int32,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array, [partition_index: :int32, timestamp: :int64, max_num_offsets: :int32]}
         ]}
    ]

  def request_schema(1),
    do: [
      replica_id: :int32,
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, timestamp: :int64]}]}
    ]

  def request_schema(2),
    do: [
      replica_id: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, timestamp: :int64]}]}
    ]

  def request_schema(3),
    do: [
      replica_id: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [name: :string, partitions: {:array, [partition_index: :int32, timestamp: :int64]}]}
    ]

  def request_schema(4),
    do: [
      replica_id: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array, [partition_index: :int32, current_leader_epoch: :int32, timestamp: :int64]}
         ]}
    ]

  def request_schema(5),
    do: [
      replica_id: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array, [partition_index: :int32, current_leader_epoch: :int32, timestamp: :int64]}
         ]}
    ]

  def request_schema(6),
    do: [
      replica_id: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                current_leader_epoch: :int32,
                timestamp: :int64,
                tag_buffer: %{}
              ]},
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]

  def request_schema(7),
    do: [
      replica_id: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                current_leader_epoch: :int32,
                timestamp: :int64,
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
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, error_code: :int16, old_style_offsets: {:array, :int64}]}
         ]}
    ]

  def response_schema(1),
    do: [
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, error_code: :int16, timestamp: :int64, offset: :int64]}
         ]}
    ]

  def response_schema(2),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, error_code: :int16, timestamp: :int64, offset: :int64]}
         ]}
    ]

  def response_schema(3),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [partition_index: :int32, error_code: :int16, timestamp: :int64, offset: :int64]}
         ]}
    ]

  def response_schema(4),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                timestamp: :int64,
                offset: :int64,
                leader_epoch: :int32
              ]}
         ]}
    ]

  def response_schema(5),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                timestamp: :int64,
                offset: :int64,
                leader_epoch: :int32
              ]}
         ]}
    ]

  def response_schema(6),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                timestamp: :int64,
                offset: :int64,
                leader_epoch: :int32,
                tag_buffer: %{}
              ]},
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]

  def response_schema(7),
    do: [
      throttle_time_ms: :int32,
      topics:
        {:array,
         [
           name: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                timestamp: :int64,
                offset: :int64,
                leader_epoch: :int32,
                tag_buffer: %{}
              ]},
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]
end