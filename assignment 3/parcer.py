

class Parser:
    def __init__(self, tokens):
        self.tokens = tokens
        self.i = 0

    def peek(self):
        return self.tokens[self.i]

    def eat(self, type_):
        if self.peek()[0] != type_:
            raise SyntaxError(f"Expected {type_}, got {self.peek()}")
        tok = self.peek()
        self.i += 1
        return tok

    def parse(self):
        cmd = self.parse_command()
        self.eat("EOF")
        return cmd

    def parse_command(self):
        ttype, tval = self.peek()

        if tval == "ls":
            self.eat("COMMAND")
            if self.peek()[0] in ("BSLASH", "IDENT"):
                return ("ls", self.parse_path())
            return ("ls", None)

        if tval == "cd":
            self.eat("COMMAND")
            if self.peek()[0] in ("BSLASH", "IDENT"):
                return ("cd", self.parse_path())
            return ("cd", None)

        if tval == "cat":
            self.eat("COMMAND")
            fname = self.eat("FILENAME")[1]
            return ("cat", fname)

        if tval == "print":
            self.eat("COMMAND")
            fname = self.eat("FILENAME")[1]
            return ("print", fname)

        if tval == "exec":
            self.eat("COMMAND")
            fname = self.eat("FILENAME")[1]
            return ("exec", fname)

        raise SyntaxError("Unknown command")

    def parse_path(self):
        parts = []
        absolute = False

        # path starting with "\"
        if self.peek()[0] == "BSLASH":
            absolute = True
            self.eat("BSLASH")

        parts.append(self.eat("IDENT")[1])

        # more \IDENT
        while self.peek()[0] == "BSLASH":
            self.eat("BSLASH")
            parts.append(self.eat("IDENT")[1])

        return ("path", absolute, parts)
