package com.example.myhompage.exception;

public class NotExistMemberException extends Exception {
    public NotExistMemberException() {
        super("존재하지 않는 회원입니다.");
    }
}
