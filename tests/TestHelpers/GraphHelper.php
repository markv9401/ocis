<?php declare(strict_types=1);
/**
 * ownCloud
 *
 * @author Kiran Parajuli <kiran@jankaritech.com>
 * @copyright Copyright (c) 2022 Kiran Parajuli kiran@jankaritech.com
 */

namespace TestHelpers;

use TestHelpers\HttpRequestHelper;
use GuzzleHttp\Exception\GuzzleException;
use Psr\Http\Message\RequestInterface;
use Psr\Http\Message\ResponseInterface;

/**
 * A helper class for managing Graph API requests
 */
class GraphHelper {
	/**
	 * @return string[]
	 */
	private static function getRequestHeaders(): array {
		return [
			'Content-Type' => 'application/json',
		];
	}

	/**
	 * @param string $baseUrl
	 * @param string $path
	 *
	 * @return string
	 */
	private static function getFullUrl(string $baseUrl, string $path): string {
		$fullUrl = $baseUrl;
		if (\substr($fullUrl, -1) !== '/') {
			$fullUrl .= '/';
		}
		$fullUrl .= 'graph/v1.0/' . $path;
		return $fullUrl;
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $method
	 * @param string $path
	 * @param string|null $body
	 * @param array|null $headers
	 *
	 * @return RequestInterface
	 * @throws GuzzleException
	 */
	public static function createRequest(
		string $baseUrl,
		string $xRequestId,
		string $method,
		string $path,
		?string $body = null,
		?array $headers = []
	): RequestInterface {
		$fullUrl = self::getFullUrl($baseUrl, $path);
		return HttpRequestHelper::createRequest(
			$fullUrl,
			$xRequestId,
			$method,
			$headers,
			$body
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $userName
	 * @param string $password
	 * @param string|null $email
	 * @param string|null $displayName
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function createUser(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $userName,
		string $password,
		?string $email = null,
		?string $displayName = null
	): ResponseInterface {
		$payload = self::prepareCreateUserPayload(
			$userName,
			$password,
			$email,
			$displayName
		);

		$url = self::getFullUrl($baseUrl, 'users');
		return HttpRequestHelper::post(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
			self::getRequestHeaders(),
			$payload
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $userId
	 * @param string|null $userName
	 * @param string|null $password
	 * @param string|null $email
	 * @param string|null $displayName
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function editUser(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $userId,
		?string $userName = null,
		?string $password = null,
		?string $email = null,
		?string $displayName = null
	): ResponseInterface {
		$payload = self::preparePatchUserPayload(
			$userName,
			$password,
			$email,
			$displayName
		);
		$url = self::getFullUrl($baseUrl, 'users/' . $userId);
		return HttpRequestHelper::sendRequest(
			$url,
			$xRequestId,
			"PATCH",
			$adminUser,
			$adminPassword,
			self::getRequestHeaders(),
			$payload
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $userName
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function getUser(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $userName
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'users/' . $userName);
		return HttpRequestHelper::get(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
			self::getRequestHeaders()
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $userName
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function deleteUser(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $userName
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'users/' . $userName);
		return HttpRequestHelper::delete(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $groupName
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function createGroup(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $groupName
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'groups');
		$payload['displayName'] = $groupName;
		return HttpRequestHelper::sendRequest(
			$url,
			$xRequestId,
			"POST",
			$adminUser,
			$adminPassword,
			self::getRequestHeaders(),
			\json_encode($payload)
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $groupId
	 * @param string $displayName
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function updateGroup(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $groupId,
		string $displayName
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'groups/' . $groupId);
		$payload['displayName'] = $displayName;
		return HttpRequestHelper::sendRequest(
			$url,
			$xRequestId,
			"PATCH",
			$adminUser,
			$adminPassword,
			self::getRequestHeaders(),
			\json_encode($payload)
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function getUsers(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'users');
		return HttpRequestHelper::get(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
			self::getRequestHeaders(),
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function getGroups(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'groups');
		return HttpRequestHelper::get(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
			self::getRequestHeaders(),
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $groupId
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function deleteGroup(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $groupId
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'groups/' . $groupId);
		return HttpRequestHelper::delete(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $groupId
	 * @param array $users expects users array with user ids
	 *                     [ [ 'id' => 'some_id' ], ]
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function addUsersToGroup(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $groupId,
		array $users
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'groups/' . $groupId . '/users');
		$payload = [
			"members@odata.bind" => []
		];
		foreach ($users as $user) {
			$payload[0][] = self::getFullUrl($baseUrl, 'users/' . $user["id"]);
		}
		return HttpRequestHelper::post(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
			self::getRequestHeaders(),
			\json_encode($payload)
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $userId
	 * @param string $groupId
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function addUserToGroup(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $userId,
		string $groupId
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'groups/' . $groupId . '/members/$ref');
		$body = [
			"@odata.id" => self::getFullUrl($baseUrl, 'users/' . $userId)
		];
		return HttpRequestHelper::post(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
			self::getRequestHeaders(),
			\json_encode($body)
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $userId
	 * @param string $groupId
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function removeUserFromGroup(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $userId,
		string $groupId
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'groups/' . $groupId . '/members/' . $userId . '/$ref');
		return HttpRequestHelper::delete(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword,
		);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $adminUser
	 * @param string $adminPassword
	 * @param string $groupId
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function getMembersList(
		string $baseUrl,
		string $xRequestId,
		string $adminUser,
		string $adminPassword,
		string $groupId
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'groups/' . $groupId . '/members');
		return HttpRequestHelper::get(
			$url,
			$xRequestId,
			$adminUser,
			$adminPassword
		);
	}

	/**
	 * returns json encoded payload for user creating request
	 *
	 * @param string|null $userName
	 * @param string|null $password
	 * @param string|null $email
	 * @param string|null $displayName
	 *
	 * @return string
	 */
	public static function prepareCreateUserPayload(
		string $userName,
		string $password,
		?string $email,
		?string $displayName
	): string {
		$payload['onPremisesSamAccountName'] = $userName;
		$payload['passwordProfile'] = ['password' => $password];
		$payload['displayName'] = $displayName ?? $userName;
		$payload['mail'] = $email ?? $userName . '@example.com';
		return \json_encode($payload);
	}

	/**
	 * returns encoded json payload for user patching requests
	 *
	 * @param string|null $userName
	 * @param string|null $password
	 * @param string|null $email
	 * @param string|null $displayName
	 *
	 * @return string
	 */
	public static function preparePatchUserPayload(
		?string $userName,
		?string $password,
		?string $email,
		?string $displayName
	): string {
		$payload = [];
		if ($userName) {
			$payload['onPremisesSamAccountName'] = $userName;
		}
		if ($password) {
			$payload['passwordProfile'] = ['password' => $password];
		}
		if ($displayName) {
			$payload['displayName'] = $displayName;
		}
		if ($email) {
			$payload['mail'] = $email;
		}
		return \json_encode($payload);
	}

	/**
	 * Send Graph Create Space Request
	 *
	 * @param string $baseUrl
	 * @param  string $user
	 * @param  string $password
	 * @param  string $body
	 * @param  string $xRequestId
	 * @param  array  $headers
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function createSpace(
		string $baseUrl,
		string $user,
		string $password,
		string $body,
		string $xRequestId = '',
		array $headers = []
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'drives');

		return HttpRequestHelper::post($url, $xRequestId, $user, $password, $headers, $body);
	}

	/**
	 * Send Graph Update Space Request
	 *
	 * @param  string $baseUrl
	 * @param  string $user
	 * @param  string $password
	 * @param  mixed $body
	 * @param  string $spaceId
	 * @param  string $xRequestId
	 * @param  array  $headers
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function updateSpace(
		string $baseUrl,
		string $user,
		string $password,
		$body,
		string $spaceId,
		string $xRequestId = '',
		array $headers = []
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'drives/' . $spaceId);

		return HttpRequestHelper::sendRequest($url, $xRequestId, 'PATCH', $user, $password, $headers, $body);
	}

	/**
	 * Send Graph List My Spaces Request
	 *
	 * @param  string $baseUrl
	 * @param  string $user
	 * @param  string $password
	 * @param  string $urlArguments
	 * @param  string $xRequestId
	 * @param  array  $body
	 * @param  array  $headers
	 *
	 * @return ResponseInterface
	 *
	 * @throws GuzzleException
	 */
	public static function getMySpaces(
		string $baseUrl,
		string $user,
		string $password,
		string $urlArguments = '',
		string $xRequestId = '',
		array  $body = [],
		array  $headers = []
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'me/drives/' . $urlArguments);

		return HttpRequestHelper::get($url, $xRequestId, $user, $password, $headers, $body);
	}

	/**
	 * Send Graph List All Spaces Request
	 *
	 * @param  string $baseUrl
	 * @param  string $user
	 * @param  string $password
	 * @param  string $urlArguments
	 * @param  string $xRequestId
	 * @param  array  $body
	 * @param  array  $headers
	 *
	 * @return ResponseInterface
	 *
	 * @throws GuzzleException
	 */
	public static function getAllSpaces(
		string $baseUrl,
		string $user,
		string $password,
		string $urlArguments = '',
		string $xRequestId = '',
		array  $body = [],
		array  $headers = []
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'drives/' . $urlArguments);

		return HttpRequestHelper::get($url, $xRequestId, $user, $password, $headers, $body);
	}

	/**
	 * Send Graph List Single Space Request
	 *
	 * @param string $baseUrl
	 * @param string $user
	 * @param string $password
	 * @param string $spaceId
	 * @param string $urlArguments
	 * @param string $xRequestId
	 * @param array $body
	 * @param array $headers
	 *
	 * @return ResponseInterface
	 *
	 */
	public static function getSingleSpace(
		string $baseUrl,
		string $user,
		string $password,
		string $spaceId,
		string $urlArguments = '',
		string $xRequestId = '',
		array  $body = [],
		array  $headers = []
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'drives/' . $spaceId . "/" . $urlArguments);

		return HttpRequestHelper::get($url, $xRequestId, $user, $password, $headers, $body);
	}

	/**
	 * send disable space request
	 *
	 * @param string $baseUrl
	 * @param string $user
	 * @param string $password
	 * @param string $spaceId
	 * @param string $xRequestId
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function disableSpace(
		string $baseUrl,
		string $user,
		string $password,
		string $spaceId,
		string $xRequestId = ''
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'drives/' . $spaceId);

		return HttpRequestHelper::delete(
			$url,
			$xRequestId,
			$user,
			$password
		);
	}

	/**
	 * send delete space request
	 *
	 * @param string $baseUrl
	 * @param string $user
	 * @param string $password
	 * @param string $spaceId
	 * @param string $xRequestId
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function deleteSpace(
		string $baseUrl,
		string $user,
		string $password,
		string $spaceId,
		string $xRequestId = ''
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'drives/' . $spaceId);
		$header = ["Purge" => "T"];

		return HttpRequestHelper::delete(
			$url,
			$xRequestId,
			$user,
			$password,
			$header
		);
	}

	/**
	 * Send restore Space Request
	 *
	 * @param  string $baseUrl
	 * @param  string $user
	 * @param  string $password
	 * @param  string $spaceId
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function restoreSpace(
		string $baseUrl,
		string $user,
		string $password,
		string $spaceId
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'drives/' . $spaceId);
		$header = ["restore" => true];
		$body = '{}';

		return HttpRequestHelper::sendRequest($url, '', 'PATCH', $user, $password, $header, $body);
	}

	/**
	 * @param string $baseUrl
	 * @param string $xRequestId
	 * @param string $user
	 * @param string $password
	 * @param string $currentPassword
	 * @param string $newPassword
	 *
	 * @return ResponseInterface
	 * @throws GuzzleException
	 */
	public static function changeOwnPassword(
		string $baseUrl,
		string $xRequestId,
		string $user,
		string $password,
		string $currentPassword,
		string $newPassword
	): ResponseInterface {
		$url = self::getFullUrl($baseUrl, 'me/changePassword');
		$payload['currentPassword'] = $currentPassword;
		$payload['newPassword'] = $newPassword;

		return HttpRequestHelper::sendRequest(
			$url,
			$xRequestId,
			"POST",
			$user,
			$password,
			self::getRequestHeaders(),
			\json_encode($payload)
		);
	}
}
