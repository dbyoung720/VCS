@echo off
SETLOCAL EnableDelayedExpansion

set BuildRootPath=%1
set BuildPlatform=%2
set SourceCodeName=%3
set VCProjectNameX=%4

CMake -DWITH_BOOST=%DriverPath%\boost_1_77_0 -DBUILD_TESTING=OFF -DWITH_ROUTER=OFF -DWITH_UNIT_TESTS=OFF -DZSTD_USE_STATIC_RUNTIME=ON -DZSTD_MULTITHREAD_SUPPORT=ON  -DCMAKE_INSTALL_PREFIX=%VSSDK%/mysql -Thost=%Platform1% -A %Platform2% -B "%BuildPathX%" -G "%BuildLanguage%" -S "%SourcePath%"
CMake %BuildPathX%
Call %BuildRootPath%src\vcm.cmd %BuildRootPath% %BuildPathX% %SourceCodeName% %Platform2%

echo.> %BuildPathX%\CMakeFiles\3.26.4\CompilerIdC\CompilerIdC.pdb
echo.> %BuildPathX%\CMakeFiles\3.26.4\CompilerIdCXX\CompilerIdCXX.pdb
echo.> %BuildPathX%\library_output_directory\Release\json_binlog.pdb
echo.> %BuildPathX%\library_output_directory\Release\libmysql.pdb
echo.> %BuildPathX%\library_output_directory\Release\libprotobuf-lite.pdb
echo.> %BuildPathX%\library_output_directory\Release\libprotobuf.pdb
echo.> %BuildPathX%\library_output_directory\Release\libprotoc.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\adt_null.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\auth.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\auth_test_plugin.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_audit_api_message_emit.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_example_component1.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_example_component2.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_example_component3.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_keyring_file.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_log_filter_dragnet.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_log_sink_json.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_log_sink_syseventlog.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_log_sink_test.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_mysqlbackup.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_mysqlx_global_reset.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_pfs_example.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_pfs_example_component_population.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_query_attributes.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_reference_cache.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_audit_api_message.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_backup_lock_service.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_component_deinit.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_host_application_signal.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_mysql_command_services.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_mysql_current_thread_reader.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_mysql_runtime_error.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_mysql_system_variable_set.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_mysql_thd_store_service.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_pfs_notification.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_pfs_resource_group.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_sensitive_system_variables.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_server_telemetry_traces.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_status_var_reader.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_status_var_service.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_status_var_service_int.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_status_var_service_reg_only.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_status_var_service_str.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_status_var_service_unreg_only.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_string_service.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_string_service_charset.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_string_service_long.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_system_variable_source.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_sys_var_service.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_sys_var_service_int.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_sys_var_service_same.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_sys_var_service_str.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_table_access.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_udf_registration.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_test_udf_services.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_reg_3_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_reg_avg_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_reg_int_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_reg_int_same_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_reg_only_3_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_reg_real_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_unreg_3_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_unreg_int_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_udf_unreg_real_func.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\component_validate_password.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\conflicting_variables.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\connection_control.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\ddl_rewriter.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\group_replication.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\ha_example.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\ha_mock.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\keyring_file.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\keyring_udf.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libdaemon_example.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_framework.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_services.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_services_threaded.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_session_attach.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_session_detach.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_session_info.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_session_in_thd.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_2_sessions.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_all_col_types.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_cmds_1.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_commit.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_complex.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_errors.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_lock.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_processlist.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_replication.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_reset_connection.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_shutdown.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_sleep_is_connected.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_sqlmode.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_stmt.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_stored_procedures_functions.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_sql_views_triggers.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_x_sessions_deinit.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\libtest_x_sessions_init.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\locking_service.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\mypluglib.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\mysql_clone.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\mysql_no_login.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\pfs_example_plugin_employee.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\qa_auth_client.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\qa_auth_interface.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\qa_auth_server.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\replication_observers_example_plugin.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\rewriter.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\rewrite_example.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\semisync_master.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\semisync_replica.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\semisync_slave.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\semisync_source.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\test_security_context.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\test_services_command_services.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\test_services_host_application_signal.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\test_services_plugin_registry.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\test_udf_services.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\udf_example.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\validate_password.pdb
echo.> %BuildPathX%\plugin_output_directory\Release\version_token.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\json_binlog.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\libcrypto-3-x64.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\libmysql.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\libprotobuf-lite.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\libprotobuf.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\libprotoc.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\libssl-3-x64.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\comp_client_err.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\comp_err.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\comp_sql.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\conf_to_src.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\create_def.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\echo.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\gen_keyword_list.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\gen_lex_hash.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\gen_lex_token.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\ibd2sdi.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\innochecksum.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\installed_headers.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\json_binlog_main.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\json_binlog_main_static.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\json_client_library_main.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\libmysql_api_test.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\lz4_decompress.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mf_iocache_test.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\myisamchk.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\myisamlog.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\myisampack.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\myisam_ftdump.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqladmin.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqlbinlog.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqlcheck.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqld.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqldump.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqlimport.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqlpump.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqlshow.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqlslap.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqltest.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqltest_safe_kill.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqltest_safe_process.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysqlxtest.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql_client_test.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql_config_editor.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql_keyring_encryption_test.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql_migrate_keyring.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql_secure_installation.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql_ssl_rsa_setup.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql_tzinfo_to_sql.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\mysql_upgrade.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\my_openssl.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\my_print_defaults.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\perror.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\protoc.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\range_check_err.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\thr_lock.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\uca9dump.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\xprotocol_plugin.pdb
echo.> %BuildPathX%\runtime_output_directory\Release\zlib_decompress.pdb

CMake --build %BuildPathX% --config Release --target install