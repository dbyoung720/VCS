# CMake 的最低版本要求
cmake_minimum_required(VERSION 3.16)

# 工程文件名称
set(PROJECT_NAME lmdb) 

# 设置代码是何种语言编写
project(${PROJECT_NAME} C)

# 设置 C 语言规范版本
set(CMAKE_C_STANDARD 11)

# 指定 lmdb 源代码目录；CMAKE_CURRENT_SOURCE_DIR 是 CMakeLists.txt 所在的目录
set(LMDB_SOURCE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/libraries/liblmdb)

# 指定编译 lmdb 源码要使用到的文件
set(SRC_LIB_FILE    ${LMDB_SOURCE_PATH}/mdb.c ${LMDB_SOURCE_PATH}/midl.c)
file(GLOB HDR_FILES ${LMDB_SOURCE_PATH}/*.h)

# 编译静态库
set(LMDB_STATIC_NAME "${PROJECT_NAME}")
add_library(${LMDB_STATIC_NAME} STATIC ${SRC_LIB_FILE})

# unistd.h 头文件路径搜索
INCLUDE_DIRECTORIES( ${CMAKE_CURRENT_SOURCE_DIR} )

# 编译可执行文件
add_executable(mdb_stat ${LMDB_SOURCE_PATH}/mdb_stat.c ${CMAKE_CURRENT_SOURCE_DIR}/getopt.c) 
add_executable(mdb_copy ${LMDB_SOURCE_PATH}/mdb_copy.c ${CMAKE_CURRENT_SOURCE_DIR}/getopt.c) 
add_executable(mdb_dump ${LMDB_SOURCE_PATH}/mdb_dump.c ${CMAKE_CURRENT_SOURCE_DIR}/getopt.c) 
add_executable(mdb_load ${LMDB_SOURCE_PATH}/mdb_load.c ${CMAKE_CURRENT_SOURCE_DIR}/getopt.c) 
add_executable(mdb_drop ${LMDB_SOURCE_PATH}/mdb_drop.c ${CMAKE_CURRENT_SOURCE_DIR}/getopt.c) 
target_link_libraries(mdb_stat ${LMDB_STATIC_NAME})
target_link_libraries(mdb_copy ${LMDB_STATIC_NAME})
target_link_libraries(mdb_dump ${LMDB_STATIC_NAME})
target_link_libraries(mdb_load ${LMDB_STATIC_NAME})
target_link_libraries(mdb_drop ${LMDB_STATIC_NAME})

# 编译 test 文件
add_executable(mtest  ${LMDB_SOURCE_PATH}/mtest.c) 
add_executable(mtest2 ${LMDB_SOURCE_PATH}/mtest2.c) 
add_executable(mtest3 ${LMDB_SOURCE_PATH}/mtest3.c) 
add_executable(mtest4 ${LMDB_SOURCE_PATH}/mtest4.c) 
add_executable(mtest5 ${LMDB_SOURCE_PATH}/mtest5.c) 
target_link_libraries(mtest ${LMDB_STATIC_NAME})
target_link_libraries(mtest2 ${LMDB_STATIC_NAME})
target_link_libraries(mtest3 ${LMDB_STATIC_NAME})
target_link_libraries(mtest4 ${LMDB_STATIC_NAME})
target_link_libraries(mtest5 ${LMDB_STATIC_NAME})

# test6 单独处理
add_executable(mtest6 ${LMDB_SOURCE_PATH}/mtest6.c ${SRC_LIB_FILE}) 
target_compile_definitions(mtest6 PUBLIC MDB_DEBUG) # 添加宏定义

#安装
#set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/SDK) #指定安装目录(如果不指定目录，默认是 C:\Program Files (x86)\lmdb)
set(INSTALL_BIN_DIR "${CMAKE_INSTALL_PREFIX}/bin" CACHE PATH "Installation directory for executables")
set(INSTALL_LIB_DIR "${CMAKE_INSTALL_PREFIX}/lib" CACHE PATH "Installation directory for libraries")
set(INSTALL_INC_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH "Installation directory for headers")

INSTALL (TARGETS lmdb mdb_stat mdb_copy mdb_dump mdb_load 
    RUNTIME DESTINATION "${INSTALL_BIN_DIR}" 
    LIBRARY DESTINATION "${INSTALL_LIB_DIR}" 
    ARCHIVE DESTINATION "${INSTALL_LIB_DIR}")
INSTALL (FILES ${LMDB_SOURCE_PATH}/lmdb.h DESTINATION "${INSTALL_INC_DIR}")
