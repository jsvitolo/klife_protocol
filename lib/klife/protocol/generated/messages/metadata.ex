defmodule Klife.Protocol.Messages.Metadata do
  alias Klife.Protocol.Deserializer
  alias Klife.Protocol.Serializer
  alias Klife.Protocol.Header

  def get_api_key(), do: 3

  def request_schema(0), do: [topics: {:array, [name: :string]}]
  def request_schema(1), do: [topics: {:array, [name: :string]}]
  def request_schema(2), do: [topics: {:array, [name: :string]}]
  def request_schema(3), do: [topics: {:array, [name: :string]}]

  def request_schema(4),
    do: [topics: {:array, [name: :string]}, allow_auto_topic_creation: :boolean]

  def request_schema(5),
    do: [topics: {:array, [name: :string]}, allow_auto_topic_creation: :boolean]

  def request_schema(6),
    do: [topics: {:array, [name: :string]}, allow_auto_topic_creation: :boolean]

  def request_schema(7),
    do: [topics: {:array, [name: :string]}, allow_auto_topic_creation: :boolean]

  def request_schema(8),
    do: [
      topics: {:array, [name: :string]},
      allow_auto_topic_creation: :boolean,
      include_cluster_authorized_operations: :boolean,
      include_topic_authorized_operations: :boolean
    ]

  def request_schema(9),
    do: [
      topics: {:array, [name: :string, tag_buffer: %{}]},
      allow_auto_topic_creation: :boolean,
      include_topic_authorized_operations: :boolean,
      tag_buffer: %{}
    ]

  def request_schema(10),
    do: [
      topics: {:array, [topic_id: :uuid, name: :string, tag_buffer: %{}]},
      allow_auto_topic_creation: :boolean,
      include_cluster_authorized_operations: :boolean,
      include_topic_authorized_operations: :boolean,
      tag_buffer: %{}
    ]

  def request_schema(11),
    do: [
      topics: {:array, [topic_id: :uuid, name: :string, tag_buffer: %{}]},
      allow_auto_topic_creation: :boolean,
      include_topic_authorized_operations: :boolean,
      tag_buffer: %{}
    ]

  def request_schema(12),
    do: [
      topics: {:array, [topic_id: :uuid, name: :string, tag_buffer: %{}]},
      allow_auto_topic_creation: :boolean,
      include_topic_authorized_operations: :boolean,
      tag_buffer: %{}
    ]

  def response_schema(0),
    do: [
      brokers: {:array, [node_id: :int32, host: :string, port: :int32]},
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32}
              ]}
         ]}
    ]

  def response_schema(1),
    do: [
      brokers: {:array, [node_id: :int32, host: :string, port: :int32, rack: :string]},
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32}
              ]}
         ]}
    ]

  def response_schema(2),
    do: [
      brokers: {:array, [node_id: :int32, host: :string, port: :int32, rack: :string]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32}
              ]}
         ]}
    ]

  def response_schema(3),
    do: [
      throttle_time_ms: :int32,
      brokers: {:array, [node_id: :int32, host: :string, port: :int32, rack: :string]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32}
              ]}
         ]}
    ]

  def response_schema(4),
    do: [
      throttle_time_ms: :int32,
      brokers: {:array, [node_id: :int32, host: :string, port: :int32, rack: :string]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32}
              ]}
         ]}
    ]

  def response_schema(5),
    do: [
      throttle_time_ms: :int32,
      brokers: {:array, [node_id: :int32, host: :string, port: :int32, rack: :string]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32},
                offline_replicas: {:array, :int32}
              ]}
         ]}
    ]

  def response_schema(6),
    do: [
      throttle_time_ms: :int32,
      brokers: {:array, [node_id: :int32, host: :string, port: :int32, rack: :string]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32},
                offline_replicas: {:array, :int32}
              ]}
         ]}
    ]

  def response_schema(7),
    do: [
      throttle_time_ms: :int32,
      brokers: {:array, [node_id: :int32, host: :string, port: :int32, rack: :string]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                leader_epoch: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32},
                offline_replicas: {:array, :int32}
              ]}
         ]}
    ]

  def response_schema(8),
    do: [
      throttle_time_ms: :int32,
      brokers: {:array, [node_id: :int32, host: :string, port: :int32, rack: :string]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                leader_epoch: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32},
                offline_replicas: {:array, :int32}
              ]},
           topic_authorized_operations: :int32
         ]},
      cluster_authorized_operations: :int32
    ]

  def response_schema(9),
    do: [
      throttle_time_ms: :int32,
      brokers:
        {:array, [node_id: :int32, host: :string, port: :int32, rack: :string, tag_buffer: %{}]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                leader_epoch: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32},
                offline_replicas: {:array, :int32},
                tag_buffer: %{}
              ]},
           topic_authorized_operations: :int32,
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]

  def response_schema(10),
    do: [
      throttle_time_ms: :int32,
      brokers:
        {:array, [node_id: :int32, host: :string, port: :int32, rack: :string, tag_buffer: %{}]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           topic_id: :uuid,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                leader_epoch: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32},
                offline_replicas: {:array, :int32},
                tag_buffer: %{}
              ]},
           topic_authorized_operations: :int32,
           tag_buffer: %{}
         ]},
      cluster_authorized_operations: :int32,
      tag_buffer: %{}
    ]

  def response_schema(11),
    do: [
      throttle_time_ms: :int32,
      brokers:
        {:array, [node_id: :int32, host: :string, port: :int32, rack: :string, tag_buffer: %{}]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           topic_id: :uuid,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                leader_epoch: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32},
                offline_replicas: {:array, :int32},
                tag_buffer: %{}
              ]},
           topic_authorized_operations: :int32,
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]

  def response_schema(12),
    do: [
      throttle_time_ms: :int32,
      brokers:
        {:array, [node_id: :int32, host: :string, port: :int32, rack: :string, tag_buffer: %{}]},
      cluster_id: :string,
      controller_id: :int32,
      topics:
        {:array,
         [
           error_code: :int16,
           name: :string,
           topic_id: :uuid,
           is_internal: :boolean,
           partitions:
             {:array,
              [
                error_code: :int16,
                partition_index: :int32,
                leader_id: :int32,
                leader_epoch: :int32,
                replica_nodes: {:array, :int32},
                isr_nodes: {:array, :int32},
                offline_replicas: {:array, :int32},
                tag_buffer: %{}
              ]},
           topic_authorized_operations: :int32,
           tag_buffer: %{}
         ]},
      tag_buffer: %{}
    ]
end