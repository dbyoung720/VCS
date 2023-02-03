:: Windows �� VC ���뿪ԴԴ����
@echo off
setlocal enabledelayedexpansion
color A

@echo ���б�����ʱ����ȷ�� tools �Ѿ���װ��

set CodeName=%1
set Platform=%2
set RootPath=%~dp0
set ProjName=%CodeName%

@echo ���� %CodeName%
title ���� %CodeName%

:: ���û�������
call %RootPath%src\env.cmd %RootPath% %Platform% %CodeName%

:: ����� patch �����ļ����� CodeName �򲹶�
set "PatchFileName=%RootPath%patch\%CodeName%.patch"
if exist %PatchFileName% (
  CD /D "%SourcePath%"
  git apply --ignore-space-change --ignore-whitespace -v %RootPath%patch\%CodeName%.patch
)

:: ִ�б���ǰ�Ķ���
set "beforecmd=%RootPath%patch\before_%CodeName%.cmd"
if exist %beforecmd% (
  call %beforecmd% %RootPath% %SourcePath% %CodeName%
)

:: ��ʼ����
if exist %RootPath%patch\%CodeName%.cmd (
  :: ������������Ѵ��ڣ�ʹ�ö�������
  call %RootPath%patch\%CodeName%.cmd %RootPath% %Platform% %CodeName% %ProjName%
) else (
  :: ����������벻���ڣ�ʹ��ͨ�ñ���
  call %RootPath%src\CommonCore.cmd  %RootPath% %Platform% %CodeName% %ProjName%
)

:: ִ�б����Ժ�Ķ���
set "aftercmd=%RootPath%patch\after_%CodeName%.cmd"
if exist %aftercmd% (
  call %aftercmd% %VSSDK%
)

:: Դ���뻹ԭ
cd /D "%SourcePath%"

:: git Դ���뻹ԭ 
if exist "%SourcePath%\.git\" (
  git clean -d -fx -f
  git checkout .
)

:: svn Դ���뻹ԭ 
if exist "%SourcePath%\.svn\" (
  svn cleanup --remove-ignored --remove-unversioned
  svn revert  --recursive .
)

:: �ص� vcs Ŀ¼
CD /D %RootPath%
