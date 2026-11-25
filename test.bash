#!/bin/bash
# SPDX-FileCopyrightText: 2026 Hiroki Ueno
# SPDX-License-Identifier: BSD-3-Clause

ng () {
    echo "${1}行目が違うよ"
    res=1
}

res=0

### 正常系テスト（"abbccc" -> C:3回, B:2回, A:1回） ###
out=$(echo "abbccc" | ./sortchar)
echo "$out" | grep -q "総数: 6文字" || ng "$LINENO"
echo "$out" | grep -q "C,    3回,50.00%" || ng "$LINENO"
echo "$out" | grep -q "B,    2回,33.33%" || ng "$LINENO"
echo "$out" | grep -q "A,    1回,16.67%" || ng "$LINENO"

### 空入力テスト（0文字でもエラーにならないか） ###
out=$(printf "" | ./sortchar)
echo "$out" | grep -q "総数: 0文字" || ng "$LINENO"
echo "$out" | grep -q "A,    0回,0.00%" || ng "$LINENO"

### 数字入力テスト（数字でもエラーにならないか） ###
out=$(printf "12345" | ./sortchar)
echo "$out" | grep -q "総数: 0文字" || ng "$LINENO"
echo "$out" | grep -q "A,    0回,0.00%" || ng "$LINENO"

### 全角入力テスト（全角でもエラーにならないか） ###
out=$(printf "全角" | ./sortchar)
echo "$out" | grep -q "総数: 0文字" || ng "$LINENO"
echo "$out" | grep -q "A,    0回,0.00%" || ng "$LINENO"

[ "$res" = 0 ] && echo "OK"
exit $res
