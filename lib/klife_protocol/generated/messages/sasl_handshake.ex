# DO NOT EDIT THIS FILE MANUALLY  
# This module is automatically generated by running mix task generate_file
# every change must be done inside the mix task directly

defmodule KlifeProtocol.Messages.SaslHandshake do
  @moduledoc """
  Kafka protocol SaslHandshake message

  Request versions summary:   
  - Version 1 supports SASL_AUTHENTICATE.
  NOTE: Version cannot be easily bumped due to incorrect
  client negotiation for clients <= 2.4.
  See https:issues.apache.org/jira/browse/KAFKA-9577

  Response versions summary:
  - Version 1 is the same as version 0.
  NOTE: Version cannot be easily bumped due to incorrect
  client negotiation for clients <= 2.4.
  See https:issues.apache.org/jira/browse/KAFKA-9577

  """

  alias KlifeProtocol.Deserializer
  alias KlifeProtocol.Serializer
  alias KlifeProtocol.Header

  @api_key 17
  @min_flexible_version_req :none
  @min_flexible_version_res :none

  @doc """
  Receives a map and serialize it to kafka wire format of the given version.

  Input content fields:
  - mechanism: The SASL mechanism chosen by the client. (string | versions 0+)

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

  - error_code: The error code, or 0 if there was no error. (int16 | versions 0+)
  - mechanisms: The mechanisms enabled in the server. ([]string | versions 0+)

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

  defp request_schema(0), do: [mechanism: {:string, %{is_nullable?: false}}]
  defp request_schema(1), do: [mechanism: {:string, %{is_nullable?: false}}]

  defp request_schema(unkown_version),
    do: raise("Unknown version #{unkown_version} for message SaslHandshake")

  defp response_schema(0),
    do: [
      error_code: {:int16, %{is_nullable?: false}},
      mechanisms: {{:array, :string}, %{is_nullable?: false}}
    ]

  defp response_schema(1),
    do: [
      error_code: {:int16, %{is_nullable?: false}},
      mechanisms: {{:array, :string}, %{is_nullable?: false}}
    ]

  defp response_schema(unkown_version),
    do: raise("Unknown version #{unkown_version} for message SaslHandshake")
end