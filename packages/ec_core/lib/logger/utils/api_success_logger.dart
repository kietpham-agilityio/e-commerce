import 'dart:convert';
import 'package:dio/dio.dart';
import '../../di/services/logger_di.dart';

/// Utility class for logging API success responses with detailed information
class ApiSuccessLogger {
  /// Log a successful API response with comprehensive details
  static void logSuccess({
    required String method,
    required String url,
    required int statusCode,
    required Duration duration,
    dynamic responseData,
    Map<String, dynamic>? requestHeaders,
    Map<String, dynamic>? responseHeaders,
    dynamic requestData,
  }) {
    final message = _buildSuccessMessage(
      method: method,
      url: url,
      statusCode: statusCode,
      duration: duration,
      responseData: responseData,
      requestHeaders: requestHeaders,
      responseHeaders: responseHeaders,
      requestData: requestData,
    );

    LoggerDI.success(message);
  }

  /// Log success from Dio Response object
  static void logSuccessFromResponse({
    required Response response,
    required Duration duration,
  }) {
    logSuccess(
      method: response.requestOptions.method,
      url: response.requestOptions.uri.toString(),
      statusCode: response.statusCode ?? 200,
      duration: duration,
      responseData: response.data,
      requestHeaders: response.requestOptions.headers,
      responseHeaders: response.headers.map,
      requestData: response.requestOptions.data,
    );
  }

  /// Build formatted success message
  static String _buildSuccessMessage({
    required String method,
    required String url,
    required int statusCode,
    required Duration duration,
    dynamic responseData,
    Map<String, dynamic>? requestHeaders,
    Map<String, dynamic>? responseHeaders,
    dynamic requestData,
  }) {
    final buffer = StringBuffer();

    // Main success line
    buffer.writeln('✅ API SUCCESS');
    buffer.writeln('═══════════════════════════════════════');

    // Request details
    buffer.writeln('📤 REQUEST:');
    buffer.writeln('   Method: $method');
    buffer.writeln('   URL: $url');
    buffer.writeln('   Duration: ${duration.inMilliseconds}ms');

    // Response details
    buffer.writeln();
    buffer.writeln('📥 RESPONSE:');
    buffer.writeln('   Status Code: $statusCode');

    // Request data (if present)
    if (requestData != null) {
      buffer.writeln();
      buffer.writeln('📝 REQUEST DATA:');
      buffer.writeln('   ${_formatData(requestData)}');
    }

    // Response data (truncated if too long)
    if (responseData != null) {
      buffer.writeln();
      buffer.writeln('📋 RESPONSE DATA:');
      buffer.writeln('   ${_formatResponseData(responseData)}');
    }

    // Headers (optional, only show important ones)
    if (responseHeaders != null && responseHeaders.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('🔍 RESPONSE HEADERS:');
      _formatImportantHeaders(responseHeaders).forEach((key, value) {
        buffer.writeln('   $key: $value');
      });
    }

    buffer.writeln('═══════════════════════════════════════');

    return buffer.toString();
  }

  /// Format data for logging (truncate if too long)
  static String _formatData(dynamic data) {
    if (data == null) return 'null';

    final dataString = data.toString();
    if (dataString.length <= 200) {
      return dataString;
    }

    return '${dataString.substring(0, 200)}... (truncated)';
  }

  /// Format response data with smart truncation and JSON formatting
  static String _formatResponseData(dynamic data) {
    if (data == null) return 'null';

    if (data is List) {
      return 'Array[${data.length}]\n${_formatJsonData(data)}';
    } else if (data is Map) {
      final keys = data.keys.take(5).join(', ');
      return 'Object{$keys}\n${_formatJsonData(data)}';
    } else {
      return _formatJsonData(data);
    }
  }

  /// Format data as pretty JSON with truncation
  static String _formatJsonData(dynamic data) {
    if (data == null) return 'null';

    try {
      // Convert to JSON string with pretty formatting
      const encoder = JsonEncoder.withIndent('  ');
      final jsonString = encoder.convert(data);

      // Truncate if too long
      if (jsonString.length <= 500) {
        return jsonString;
      }

      // Find a good truncation point (end of a complete JSON object/array)
      final truncated = jsonString.substring(0, 500);
      final lastBrace = truncated.lastIndexOf('}');
      final lastBracket = truncated.lastIndexOf(']');
      final lastComma = truncated.lastIndexOf(',');

      int truncateAt = 500;
      if (lastBrace > lastBracket && lastBrace > lastComma) {
        truncateAt = lastBrace + 1;
      } else if (lastBracket > lastComma) {
        truncateAt = lastBracket + 1;
      } else if (lastComma > 0) {
        truncateAt = lastComma;
      }

      return '${jsonString.substring(0, truncateAt)}\n... (truncated)';
    } catch (e) {
      // Fallback to string representation if JSON conversion fails
      return _formatData(data);
    }
  }

  /// Filter and format important headers
  static Map<String, dynamic> _formatImportantHeaders(
    Map<String, dynamic> headers,
  ) {
    final importantHeaders = <String, dynamic>{};

    // List of headers we want to show
    const relevantHeaders = [
      'content-type',
      'content-length',
      'cache-control',
      'x-ratelimit-remaining',
      'x-ratelimit-limit',
      'server',
      'date',
    ];

    for (final header in relevantHeaders) {
      final value = headers[header] ?? headers[header.toLowerCase()];
      if (value != null) {
        importantHeaders[header] = value;
      }
    }

    return importantHeaders;
  }

  /// Log API success with minimal information (for high-frequency calls)
  static void logMinimalSuccess({
    required String method,
    required String url,
    required int statusCode,
    required Duration duration,
  }) {
    final message =
        '✅ $method $url → $statusCode (${duration.inMilliseconds}ms)';
    LoggerDI.success(message);
  }

  /// Log batch API success (for multiple simultaneous requests)
  static void logBatchSuccess({
    required List<String> endpoints,
    required Duration totalDuration,
    required int successCount,
    required int totalCount,
  }) {
    final message = StringBuffer();
    message.writeln('✅ BATCH API SUCCESS');
    message.writeln('═══════════════════════════════════════');
    message.writeln('📊 Results: $successCount/$totalCount successful');
    message.writeln('⏱️ Total Duration: ${totalDuration.inMilliseconds}ms');
    message.writeln('📋 Endpoints:');

    for (final endpoint in endpoints.take(5)) {
      message.writeln('   • $endpoint');
    }

    if (endpoints.length > 5) {
      message.writeln('   • ... and ${endpoints.length - 5} more');
    }

    message.writeln('═══════════════════════════════════════');

    LoggerDI.success(message.toString());
  }
}
