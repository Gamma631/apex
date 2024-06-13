public with sharing class Calculator {
    public Calculator() {

    }

    public Integer Add(Integer a, Integer b) {
        return a + b;
    }

    public Integer Multiply(Integer a, Integer b) {
        Integer sum = b;
        if (a == 0 || b == 0) {
            return 0;
        }
        else if (a < 0 && b < 0) {
            sum = Math.abs(sum);
            for (Integer i = 0; i <= Math.abs(a); i++) {
                sum = Add(Math.abs(sum), Math.abs(b));
            }
            return sum;
        }
        else if (a < 0) {
            for (Integer i = 0; i <= Math.abs(a); i++) {
                sum = Add(sum, b);
            }
            return sum;
        }
        else {
            for (Integer i = 0; i <= a; i++) {
                sum = Add(sum, b);
            }
            return sum;
        }
    }

    public Integer Divide(Integer a, Integer b) {
        if (b == 0) {
            return null;
        }
        else if (a == 0) {
            return 0;
        }
        else {
            Integer count = 0;
            Integer absA = Math.abs(a);
            Integer negB = -Math.abs(b);
            Integer curr = absA;
            for (Integer i = 0; i < absA; i++) {
                curr = Add(curr, negB);
                if (curr >= 0) {
                    count += 1;
                }
            }
            if (a < 0 && b < 0) {
                return count;
            }
            else if (a > 0 && b > 0) {
                return count;
            }
            else {
                return -count;
            }
        }
    }

    public Integer Mod(Integer a, Integer b) {
        if (a == 0){
            return 0;
        }
        else if (b == 0) {
            return null;
        }
        else {
            Integer curr = a;
            for (int i = 0; i < a; i ++) {
                curr = Add(curr, -Math.abs(b));
                if (curr > Math.abs(b) || curr == 0) {
                    break;
                }
            }
            if (a > 0 && b < 0) {
                return -curr;
            }
            else {
                return curr;
            }
        }
    }

    public Integer Calculate(String s) {
        //this is a lot of text processing
    }
}