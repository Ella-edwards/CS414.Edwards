

def tokenize(s):
    tokens = []
    i = 0
    
    while i < len(s):
        c = s[i]

        # skip whitespace
        if c.isspace():
            i += 1
            continue

        # backslash
        if c == "\\":
            tokens.append(("BSLASH", "\\"))
            i += 1
            continue

        # filename (8 letters, dot, 3 letters)
        if i + 12 <= len(s) and s[i+8] == '.':
            name = s[i:i+8]
            ext  = s[i+9:i+12]
            if name.isalpha() and ext.isalpha():
                tokens.append(("FILENAME", s[i:i+12]))
                i += 12
                continue

        # identifier (1–8 letters)
        if c.isalpha():
            start = i
            while i < len(s) and s[i].isalpha():
                i += 1
            word = s[start:i]

            # try commands
            low = word.lower()
            if low in ["ls", "cd", "cat", "print", "exec"]:
                tokens.append(("COMMAND", low))
            else:
                tokens.append(("IDENT", word))
            continue

        raise ValueError(f"Invalid character: {c}")

    tokens.append(("EOF", ""))
    return tokens
