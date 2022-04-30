package com.example.myhompage.exception;

public class WrongPasswordException extends Exception {
    public WrongPasswordException() {
        super("비밀번호를 잘못 입력하셨습니다.");
    }
}
