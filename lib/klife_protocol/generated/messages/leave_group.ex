# DO NOT EDIT THIS FILE MANUALLY  
# This module is automatically generated by running mix task generate_file
# every change must be done inside the mix task directly

defmodule KlifeProtocol.Messages.LeaveGroup do
  @moduledoc """
  Kafka protocol LeaveGroup message

  Request versions summary:   
  - Version 1 and 2 are the same as version 0.
  - Version 3 defines batch processing scheme with group.instance.id + member.id for identity
  - Version 4 is the first flexible version.
  - Version 5 adds the Reason field (KIP-800).

  Response versions summary:
  - Version 1 adds the throttle time.
  - Starting in version 2, on quota violation, brokers send out responses before throttling.
  - Starting in version 3, we will make leave group request into batch mode and add group.instance.id.
  - Version 4 is the first flexible version.
  - Version 5 is the same as version 4.

  """

  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 13
  @min_flexible_version_req 4
  @min_flexible_version_res 4

  @doc """
  Receives a map and serialize it to kafka wire format of the given version.

  Input content fields:
  - group_id: The ID of the group to leave. (string | versions 0+)
  - member_id: The member ID to remove from the group. (string | versions 0-2)
  - members: List of leaving member identities. ([]MemberIdentity | versions 3+)
      - member_id: The member ID to remove from the group. (string | versions 3+)
      - group_instance_id: The group instance ID to remove from the group. (string | versions 3+)
      - reason: The reason why the member left the group. (string | versions 5+)

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

  - throttle_time_ms: The duration in milliseconds for which the request was throttled due to a quota violation, or zero if the request did not violate any quota. (int32 | versions 1+)
  - error_code: The error code, or 0 if there was no error. (int16 | versions 0+)
  - members: List of leaving member responses. ([]MemberResponse | versions 3+)
      - member_id: The member ID to remove from the group. (string | versions 3+)
      - group_instance_id: The group instance ID to remove from the group. (string | versions 3+)
      - error_code: The error code, or 0 if there was no error. (int16 | versions 3+)

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
  def max_supported_version(), do: 5

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
      group_id: {:string, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}}
    ]

  defp request_schema(1),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}}
    ]

  defp request_schema(2),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      member_id: {:string, %{is_nullable?: false}}
    ]

  defp request_schema(3),
    do: [
      group_id: {:string, %{is_nullable?: false}},
      members:
        {{:array,
          [
            member_id: {:string, %{is_nullable?: false}},
            group_instance_id: {:string, %{is_nullable?: true}}
          ]}, %{is_nullable?: false}}
    ]

  defp request_schema(4),
    do: [
      group_id: {:compact_string, %{is_nullable?: false}},
      members:
        {{:compact_array,
          [
            member_id: {:compact_string, %{is_nullable?: false}},
            group_instance_id: {:compact_string, %{is_nullable?: true}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp request_schema(5),
    do: [
      group_id: {:compact_string, %{is_nullable?: false}},
      members:
        {{:compact_array,
          [
            member_id: {:compact_string, %{is_nullable?: false}},
            group_instance_id: {:compact_string, %{is_nullable?: true}},
            reason: {:compact_string, %{is_nullable?: true}},
            tag_buffer: {:tag_buffer, []}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, []}
    ]

  defp request_schema(unkown_version),
    do: raise("Unknown version #{unkown_version} for message LeaveGroup")

  defp response_schema(0), do: [error_code: {:int16, %{is_nullable?: false}}]

  defp response_schema(1),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}}
    ]

  defp response_schema(2),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}}
    ]

  defp response_schema(3),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}},
      members:
        {{:array,
          [
            member_id: {:string, %{is_nullable?: false}},
            group_instance_id: {:string, %{is_nullable?: true}},
            error_code: {:int16, %{is_nullable?: false}}
          ]}, %{is_nullable?: false}}
    ]

  defp response_schema(4),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}},
      members:
        {{:compact_array,
          [
            member_id: {:compact_string, %{is_nullable?: false}},
            group_instance_id: {:compact_string, %{is_nullable?: true}},
            error_code: {:int16, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, %{}}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]

  defp response_schema(5),
    do: [
      throttle_time_ms: {:int32, %{is_nullable?: false}},
      error_code: {:int16, %{is_nullable?: false}},
      members:
        {{:compact_array,
          [
            member_id: {:compact_string, %{is_nullable?: false}},
            group_instance_id: {:compact_string, %{is_nullable?: true}},
            error_code: {:int16, %{is_nullable?: false}},
            tag_buffer: {:tag_buffer, %{}}
          ]}, %{is_nullable?: false}},
      tag_buffer: {:tag_buffer, %{}}
    ]

  defp response_schema(unkown_version),
    do: raise("Unknown version #{unkown_version} for message LeaveGroup")
end