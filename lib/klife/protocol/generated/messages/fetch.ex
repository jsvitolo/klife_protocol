defmodule Klife.Protocol.Messages.Fetch do
  alias Klife.Protocol.Deserializer
  alias Klife.Protocol.Serializer
  alias Klife.Protocol.Header

  def get_api_key(), do: 1

  def request_schema(0),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      topics:
        {:array,
         [
           topic: :string,
           partitions:
             {:array, [partition: :int32, fetch_offset: :int64, partition_max_bytes: :int32]}
         ]}
    ]

  def request_schema(1),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      topics:
        {:array,
         [
           partitions:
             {:array, [partition: :int32, fetch_offset: :int64, partition_max_bytes: :int32]}
         ]}
    ]

  def request_schema(2),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      topics:
        {:array,
         [
           partitions:
             {:array, [partition: :int32, fetch_offset: :int64, partition_max_bytes: :int32]}
         ]}
    ]

  def request_schema(3),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      topics:
        {:array,
         [
           partitions:
             {:array, [partition: :int32, fetch_offset: :int64, partition_max_bytes: :int32]}
         ]}
    ]

  def request_schema(4),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [
           partitions:
             {:array, [partition: :int32, fetch_offset: :int64, partition_max_bytes: :int32]}
         ]}
    ]

  def request_schema(5),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [
           partitions:
             {:array,
              [
                partition: :int32,
                fetch_offset: :int64,
                log_start_offset: :int64,
                partition_max_bytes: :int32
              ]}
         ]}
    ]

  def request_schema(6),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      topics:
        {:array,
         [
           partitions:
             {:array,
              [
                partition: :int32,
                fetch_offset: :int64,
                log_start_offset: :int64,
                partition_max_bytes: :int32
              ]}
         ]}
    ]

  def request_schema(7),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      session_id: :int32,
      session_epoch: :int32,
      topics:
        {:array,
         [
           partitions:
             {:array,
              [
                partition: :int32,
                fetch_offset: :int64,
                log_start_offset: :int64,
                partition_max_bytes: :int32
              ]}
         ]},
      forgotten_topics_data: {:array, [topic: :string, partitions: {:array, :int32}]}
    ]

  def request_schema(8),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      session_id: :int32,
      session_epoch: :int32,
      topics:
        {:array,
         [
           partitions:
             {:array,
              [
                partition: :int32,
                fetch_offset: :int64,
                log_start_offset: :int64,
                partition_max_bytes: :int32
              ]}
         ]},
      forgotten_topics_data: {:array, [partitions: {:array, :int32}]}
    ]

  def request_schema(9),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      session_id: :int32,
      session_epoch: :int32,
      topics:
        {:array,
         [
           partitions:
             {:array,
              [
                partition: :int32,
                current_leader_epoch: :int32,
                fetch_offset: :int64,
                log_start_offset: :int64,
                partition_max_bytes: :int32
              ]}
         ]},
      forgotten_topics_data: {:array, [partitions: {:array, :int32}]}
    ]

  def request_schema(10),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      session_id: :int32,
      session_epoch: :int32,
      topics:
        {:array,
         [
           partitions:
             {:array,
              [
                partition: :int32,
                current_leader_epoch: :int32,
                fetch_offset: :int64,
                log_start_offset: :int64,
                partition_max_bytes: :int32
              ]}
         ]},
      forgotten_topics_data: {:array, [partitions: {:array, :int32}]}
    ]

  def request_schema(11),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      session_id: :int32,
      session_epoch: :int32,
      topics:
        {:array,
         [
           partitions:
             {:array,
              [
                partition: :int32,
                current_leader_epoch: :int32,
                fetch_offset: :int64,
                log_start_offset: :int64,
                partition_max_bytes: :int32
              ]}
         ]},
      forgotten_topics_data: {:array, [partitions: {:array, :int32}]},
      rack_id: :string
    ]

  def request_schema(12),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      session_id: :int32,
      session_epoch: :int32,
      topics:
        {:array,
         [
           topic: :string,
           partitions:
             {:array,
              [
                partition: :int32,
                current_leader_epoch: :int32,
                fetch_offset: :int64,
                last_fetched_epoch: :int32,
                log_start_offset: :int64,
                partition_max_bytes: :int32,
                tag_buffer: %{}
              ]},
           tag_buffer: %{}
         ]},
      forgotten_topics_data:
        {:array, [topic: :string, partitions: {:array, :int32}, tag_buffer: %{}]},
      rack_id: :string,
      tag_buffer: %{cluster_id: {0, :string}}
    ]

  def request_schema(13),
    do: [
      replica_id: :int32,
      max_wait_ms: :int32,
      min_bytes: :int32,
      max_bytes: :int32,
      isolation_level: :int8,
      session_id: :int32,
      session_epoch: :int32,
      topics:
        {:array,
         [
           topic_id: :uuid,
           partitions:
             {:array,
              [
                partition: :int32,
                current_leader_epoch: :int32,
                fetch_offset: :int64,
                last_fetched_epoch: :int32,
                log_start_offset: :int64,
                partition_max_bytes: :int32,
                tag_buffer: %{}
              ]},
           tag_buffer: %{}
         ]},
      forgotten_topics_data:
        {:array, [topic_id: :uuid, partitions: {:array, :int32}, tag_buffer: %{}]},
      rack_id: :string,
      tag_buffer: %{cluster_id: {0, :string}}
    ]

  def response_schema(0),
    do: [
      responses:
        {:array,
         [
           topic: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                records: :records
              ]}
         ]}
    ]

  def response_schema(1),
    do: [
      throttle_time_ms: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                records: :records
              ]}
         ]}
    ]

  def response_schema(2),
    do: [
      throttle_time_ms: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                records: :records
              ]}
         ]}
    ]

  def response_schema(3),
    do: [
      throttle_time_ms: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                records: :records
              ]}
         ]}
    ]

  def response_schema(4),
    do: [
      throttle_time_ms: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                aborted_transactions: {:array, [producer_id: :int64, first_offset: :int64]},
                records: :records
              ]}
         ]}
    ]

  def response_schema(5),
    do: [
      throttle_time_ms: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions: {:array, [producer_id: :int64, first_offset: :int64]},
                records: :records
              ]}
         ]}
    ]

  def response_schema(6),
    do: [
      throttle_time_ms: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions: {:array, [producer_id: :int64, first_offset: :int64]},
                records: :records
              ]}
         ]}
    ]

  def response_schema(7),
    do: [
      throttle_time_ms: :int32,
      error_code: :int16,
      session_id: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions: {:array, [producer_id: :int64, first_offset: :int64]},
                records: :records
              ]}
         ]}
    ]

  def response_schema(8),
    do: [
      throttle_time_ms: :int32,
      error_code: :int16,
      session_id: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions: {:array, [producer_id: :int64, first_offset: :int64]},
                records: :records
              ]}
         ]}
    ]

  def response_schema(9),
    do: [
      throttle_time_ms: :int32,
      error_code: :int16,
      session_id: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions: {:array, [producer_id: :int64, first_offset: :int64]},
                records: :records
              ]}
         ]}
    ]

  def response_schema(10),
    do: [
      throttle_time_ms: :int32,
      error_code: :int16,
      session_id: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions: {:array, [producer_id: :int64, first_offset: :int64]},
                records: :records
              ]}
         ]}
    ]

  def response_schema(11),
    do: [
      throttle_time_ms: :int32,
      error_code: :int16,
      session_id: :int32,
      responses:
        {:array,
         [
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions: {:array, [producer_id: :int64, first_offset: :int64]},
                preferred_read_replica: :int32,
                records: :records
              ]}
         ]}
    ]

  def response_schema(12),
    do: [
      throttle_time_ms: :int32,
      error_code: :int16,
      session_id: :int32,
      responses:
        {:array,
         [
           topic: :string,
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions:
                  {:array, [producer_id: :int64, first_offset: :int64, tag_buffer: %{}]},
                preferred_read_replica: :int32,
                records: :records,
                tag_buffer: %{
                  0 =>
                    {:diverging_epoch,
                     {:object, [epoch: :int32, end_offset: :int64, tag_buffer: %{}]}},
                  1 =>
                    {:current_leader,
                     {:object, [leader_id: :int32, leader_epoch: :int32, tag_buffer: %{}]}},
                  2 =>
                    {:snapshot_id,
                     {:object, [end_offset: :int64, epoch: :int32, tag_buffer: %{}]}}
                }
              ]},
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]

  def response_schema(13),
    do: [
      throttle_time_ms: :int32,
      error_code: :int16,
      session_id: :int32,
      responses:
        {:array,
         [
           topic_id: :uuid,
           partitions:
             {:array,
              [
                partition_index: :int32,
                error_code: :int16,
                high_watermark: :int64,
                last_stable_offset: :int64,
                log_start_offset: :int64,
                aborted_transactions:
                  {:array, [producer_id: :int64, first_offset: :int64, tag_buffer: %{}]},
                preferred_read_replica: :int32,
                records: :records,
                tag_buffer: %{
                  0 =>
                    {:diverging_epoch,
                     {:object, [epoch: :int32, end_offset: :int64, tag_buffer: %{}]}},
                  1 =>
                    {:current_leader,
                     {:object, [leader_id: :int32, leader_epoch: :int32, tag_buffer: %{}]}},
                  2 =>
                    {:snapshot_id,
                     {:object, [end_offset: :int64, epoch: :int32, tag_buffer: %{}]}}
                }
              ]},
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]
end