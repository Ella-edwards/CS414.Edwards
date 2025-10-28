//Assignment 05: Exploring Questions of Type
//Question 1: Is C++ std::variant A Way To Pattern Match?
// CS414
//
//  Created by Ella Edwards on 10/15/25.
//

#include <iostream>
#include <memory>
#include <variant>

// --- Define the tree node types ---
struct Empty {};

struct Node {
    int value;
    std::unique_ptr<struct Tree> left;
    std::unique_ptr<struct Tree> right;
};

// The recursive variant type
using Tree = std::variant<Empty, Node>;

// --- Insert function (to build the BST) ---
void insert(Tree& t, int x) {
    struct Overloaded {
        template<class... Ts> struct Helper : Ts... { using Ts::operator()...; };
        template<class... Ts> static Helper(Ts...) -> Helper<Ts...>;
    };

    std::visit(
        Overloaded::Helper{
            [&](Empty&) {
                t = Node{x,
                         std::make_unique<Tree>(Empty{}),
                         std::make_unique<Tree>(Empty{})};
            },
            [&](Node& n) {
                if (x < n.value) insert(*n.left, x);
                else insert(*n.right, x);
            }
        },
        t
    );
}

// --- Traversals ---
void inorder(const Tree& t) {
    struct Overloaded {
        template<class... Ts> struct Helper : Ts... { using Ts::operator()...; };
        template<class... Ts> static Helper(Ts...) -> Helper<Ts...>;
    };

    std::visit(
        Overloaded::Helper{
            [](const Empty&) {},
            [](const Node& n) {
                inorder(*n.left);
                std::cout << n.value << " ";
                inorder(*n.right);
            }
        },
        t
    );
}

void preorder(const Tree& t) {
    struct Overloaded {
        template<class... Ts> struct Helper : Ts... { using Ts::operator()...; };
        template<class... Ts> static Helper(Ts...) -> Helper<Ts...>;
    };

    std::visit(
        Overloaded::Helper{
            [](const Empty&) {},
            [](const Node& n) {
                std::cout << n.value << " ";
                preorder(*n.left);
                preorder(*n.right);
            }
        },
        t
    );
}

void postorder(const Tree& t) {
    struct Overloaded {
        template<class... Ts> struct Helper : Ts... { using Ts::operator()...; };
        template<class... Ts> static Helper(Ts...) -> Helper<Ts...>;
    };

    std::visit(
        Overloaded::Helper{
            [](const Empty&) {},
            [](const Node& n) {
                postorder(*n.left);
                postorder(*n.right);
                std::cout << n.value << " ";
            }
        },
        t
    );
}

// --- Main for demonstration ---
int main() {
    Tree t = Empty{};

    insert(t, 5);
    insert(t, 2);
    insert(t, 8);
    insert(t, 1);
    insert(t, 3);

    std::cout << "Inorder: ";
    inorder(t);
    std::cout << "\nPreorder: ";
    preorder(t);
    std::cout << "\nPostorder: ";
    postorder(t);
    std::cout << "\n";

    return 0;
}
