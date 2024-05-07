#include<bits/stdc++.h>
using namespace std;

int numberOfPointer, numberOfKey;
int hopSize=0;

struct Node{
    int totalKeys;
    Node *parentNode, *nextNode;
    Node **nodePointers;
    bool isLeaf;
    string *words, *meanings;
};

Node *root;

Node *createNewNode(){
    Node *newNode = new Node();

    newNode->totalKeys = 0;
    newNode->parentNode = NULL;
    newNode->nextNode = NULL;
    newNode->nodePointers = new Node *[numberOfPointer + 1];
    for (int i=0; i<=numberOfPointer; i++){
        newNode->nodePointers[i] = nullptr;
    }
    newNode->isLeaf = true;
    newNode->words = new string[numberOfKey + 1];
    newNode->meanings = new string[numberOfKey + 1];
    return newNode;
}




void createNewRoot(Node *node,string value,Node *leftChild,Node *rightChild){
    node = createNewNode();
    node->isLeaf = false;
    node->words[0] = value;
    node->totalKeys++;
    node->nodePointers[0] = leftChild;
    node->nodePointers[1] = rightChild;
    leftChild->parentNode = node;
    rightChild->parentNode = node;
    root=node;
}

Node *searchPlace(Node *node, string word){
    while(!node->isLeaf){
        int i;
        for(i=0; i<node->totalKeys; i++){
            if(word < node->words[i]){
                break;
            }
        }
        node = node->nodePointers[i];
        hopSize++;
    }
    return node;
}


void addWithParent(Node *parent,string value,Node *rightChild){
    int track = parent->totalKeys;
    track--;

    if(track > -1){
        for(; track>-1; track--){
            if (parent->words[track] <= value)
            break;
            else{
                parent->words[track + 1] = parent->words[track];
                parent->nodePointers[track + 2] = parent->nodePointers[track+1];
            }
        }
    }
    parent->words[track + 1] = value;
    parent->nodePointers[track + 2] = rightChild;
    parent->totalKeys++;
}

void shiftUp(Node *parent, string value, Node *leftChild, Node *rightChild){
    if(!parent){
        createNewRoot(parent, value, leftChild, rightChild);
        return;
    }

    rightChild->parentNode = parent;
    addWithParent(parent, value, rightChild);

    if(parent->totalKeys == numberOfPointer){
        Node *secondNode = createNewNode();
        secondNode->isLeaf = false;

        int mark = parent->totalKeys, j = 0;

        for(int i=mark-(numberOfPointer/2); i<numberOfPointer; i++){
            secondNode->words[j] = parent->words[i];
            if(j==0){
                secondNode->nodePointers[0] = parent->nodePointers[i];   // look up later
                secondNode->nodePointers[0]->parentNode = secondNode;
            }

            secondNode->nodePointers[j + 1] = parent->nodePointers[i+1];
            secondNode->nodePointers[j + 1]->parentNode = secondNode;
            j++;
        }

        parent->totalKeys -= (mark/2+1);
        secondNode->totalKeys = (mark/2);

        shiftUp(parent->parentNode, parent->words[parent->totalKeys], parent, secondNode);
    }
}

void addToLeaf(string word, string meaning){

    Node *leaf = searchPlace(root, word);

    int track = leaf->totalKeys;
    track--;

    if(track > -1){
        for(; track>-1; track--){
            if(word < leaf->words[track]){
                leaf->words[track + 1] = leaf->words[track];
                leaf->meanings[track + 1] = leaf->meanings[track];
            }
            else break;
        }
    }
    leaf->words[track + 1] = word;
    leaf->meanings[track + 1] = meaning;
    leaf->totalKeys++;

    if(leaf->totalKeys == numberOfPointer){
        Node *secondNode = createNewNode();

        int mark = leaf->totalKeys, j = 0;
        for(int i=mark-(numberOfPointer/2); i<numberOfPointer; i++){
            secondNode->words[j] = leaf->words[i];
            secondNode->meanings[j] = leaf->meanings[i];
            j++;
        }

        leaf->totalKeys -= (numberOfPointer / 2);
        secondNode->totalKeys =(numberOfPointer / 2);
        secondNode->nextNode = leaf->nextNode;
        leaf->nextNode = secondNode;
        shiftUp(leaf->parentNode,secondNode->words[0],leaf,secondNode);
    }
}

void searchMeaning(){
    // int i;
    // cout << "Enter a word: " ;
    // string word;
    // cin >> word;

    // hopSize=0;

    // Node *leaf = searchPlace(root, word);
    // for(i=0; i<leaf->totalKeys; i++){
    //     if(leaf->words[i] == word) break;
    // }
    // // freopen("ans.txt","w",stdout);
    // if(i == leaf->totalKeys) cout << "Sorry. No word found" << endl;
    // else{
    //     cout << word << " means" << leaf->meanings[i] << endl;
    // }
    // cout << "HopSize " << hopSize << endl;

    while(true){
        int i;
        cerr << endl << "Enter [cls] to terminate the program!" << endl;
        cout << "Enter a word: " ;
        string word;
        cin >> word;
        for(int j=0; j<word.size(); j++){
            word[j] = tolower(word[j]);
        }

        if(word == "cls") {
            cout << "Thank you for using this dictionary!" << endl;
            break;
        }

        hopSize=0;

        Node *leaf = searchPlace(root, word);
        for(i=0; i<leaf->totalKeys; i++){
            if(leaf->words[i] == word) break;
        }
        // freopen("ans.txt","w",stdout);
        if(i == leaf->totalKeys) cout << "Sorry. No word found" << endl;
        else{
            cout << endl << word << " means" << leaf->meanings[i] << endl;
        }
        cout << "HopSize " << hopSize << endl << endl;
    }
}




bool buildTree(){
    string word, meaning;
    root = createNewNode();

    ifstream file;
    file.open("dictionary.txt");

    if(!file){
        cout << "File couldn't be opened" << endl;
        return false;
    }
    else{
        while(file >> word){
            getline(file, meaning);
            addToLeaf(word, meaning);
        }
        file.close();
    }
    return true;
}



int main(){
    cout << "Enter the number of pointer: ";
    cin >> numberOfPointer;
    numberOfKey = numberOfPointer - 1;

    if(buildTree()) cout << "Tree has been built successfully." << endl;
    else cout << "Sorry. Tree couldn't be built" << endl;

    searchMeaning();
    return 0;
}
