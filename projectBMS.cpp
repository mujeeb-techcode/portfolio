#include <iostream>
using namespace std;

/* =========================
   ACCOUNT STRUCTURE
   ========================= */
struct Account
{
    int accNo;
    string name;
    string password;
    double balance;
};

/* =========================
   LINKED LIST (Accounts)
   ========================= */
struct AccountNode
{
    Account acc;
    AccountNode *next;
};

AccountNode *head = NULL;

/* =========================
   STACK (Transactions)
   ========================= */
struct Transaction
{
    string type;
    double amount;
};

struct StackNode
{
    Transaction t;
    StackNode *next;
};

StackNode *transactionTop = NULL;

/* =========================
   QUEUE (Login History)
   ========================= */
struct QueueNode
{
    int accNo;
    QueueNode *next;
};

QueueNode *front = NULL;
QueueNode *rear = NULL;

/* =========================
   BST (Fast Account Search)
   ========================= */
struct BSTNode
{
    int accNo;
    Account *accRef;
    BSTNode *left;
    BSTNode *right;
};

BSTNode *bstRoot = NULL;

/* =========================
   FUNCTION DECLARATIONS
   ========================= */
void createAccount();
Account *login();
void deposit(Account *);
void withdraw(Account *);
void showTransactions();
void pushTransaction(string, double);

void enqueueLogin(int);
void showLoginHistory();

BSTNode *insertBST(BSTNode *, int, Account *);
Account *searchBST(BSTNode *, int);

/* =========================
   MAIN FUNCTION
   ========================= */
int main()
{
    int choice;
    Account *currentUser = NULL;

    do
    {
        cout << "\n==== BANKING MANAGEMENT SYSTEM ====\n";
        cout << "1. Create Account\n";
        cout << "2. Login\n";
        cout << "3. Deposit\n";
        cout << "4. Withdraw\n";
        cout << "5. Transaction History\n";
        cout << "6. Login History\n";
        cout << "7. Logout\n";
        cout << "0. Exit\n";
        cout << "Enter choice: ";
        cin >> choice;

        switch (choice)
        {
        case 1:
            createAccount();
            break;

        case 2:
            if (currentUser == NULL)
                currentUser = login();
            else
                cout << "Already logged in!\n";
            break;

        case 3:
            if (currentUser)
                deposit(currentUser);
            else
                cout << "Please login first.\n";
            break;

        case 4:
            if (currentUser)
                withdraw(currentUser);
            else
                cout << "Please login first.\n";
            break;

        case 5:
            showTransactions();
            break;

        case 6:
            showLoginHistory();
            break;

        case 7:
            currentUser = NULL;
            cout << "Logged out successfully.\n";
            break;

        case 0:
            cout << "Thank you for using the system.\n";
            break;

        default:
            cout << "Invalid choice!\n";
        }
    } while (choice != 0);

    return 0;
}

/* =========================
   CREATE ACCOUNT
   ========================= */
void createAccount()
{
    AccountNode *newNode = new AccountNode;

    cout << "Enter Account Number: ";
    cin >> newNode->acc.accNo;
    cout << "Enter Name: ";
    cin >> newNode->acc.name;
    cout << "Enter Password: ";
    cin >> newNode->acc.password;

    newNode->acc.balance = 0.0;
    newNode->next = head;
    head = newNode;

    bstRoot = insertBST(bstRoot, newNode->acc.accNo, &newNode->acc);

    cout << "Account created successfully!\n";
}

/* =========================
   LOGIN
   ========================= */
Account *login()
{
    int accNo;
    string pass;

    cout << "Enter Account Number: ";
    cin >> accNo;
    cout << "Enter Password: ";
    cin >> pass;

    Account *acc = searchBST(bstRoot, accNo);

    if (acc && acc->password == pass)
    {
        cout << "Login successful. Welcome " << acc->name << "!\n";
        enqueueLogin(accNo);
        return acc;
    }

    cout << "Invalid credentials!\n";
    return NULL;
}

/* =========================
   DEPOSIT
   ========================= */
void deposit(Account *acc)
{
    double amount;
    cout << "Enter amount to deposit: ";
    cin >> amount;

    acc->balance += amount;
    pushTransaction("Deposit", amount);

    cout << "Deposit successful. New Balance: " << acc->balance << endl;
}

/* =========================
   WITHDRAW
   ========================= */
void withdraw(Account *acc)
{
    double amount;
    cout << "Enter amount to withdraw: ";
    cin >> amount;

    if (amount > acc->balance)
    {
        cout << "Insufficient balance!\n";
        return;
    }

    acc->balance -= amount;
    pushTransaction("Withdraw", amount);

    cout << "Withdraw successful. New Balance: " << acc->balance << endl;
}

/* =========================
   STACK OPERATIONS
   ========================= */
void pushTransaction(string type, double amount)
{
    StackNode *newNode = new StackNode;
    newNode->t.type = type;
    newNode->t.amount = amount;
    newNode->next = transactionTop;
    transactionTop = newNode;
}

void showTransactions()
{
    StackNode *temp = transactionTop;

    if (!temp)
    {
        cout << "No transactions found.\n";
        return;
    }

    cout << "\n--- Transaction History ---\n";
    while (temp)
    {
        cout << temp->t.type << " : " << temp->t.amount << endl;
        temp = temp->next;
    }
}

/* =========================
   QUEUE OPERATIONS
   ========================= */
void enqueueLogin(int accNo)
{
    QueueNode *newNode = new QueueNode;
    newNode->accNo = accNo;
    newNode->next = NULL;

    if (!rear)
    {
        front = rear = newNode;
    }
    else
    {
        rear->next = newNode;
        rear = newNode;
    }
}

void showLoginHistory()
{
    QueueNode *temp = front;

    if (!temp)
    {
        cout << "No login history.\n";
        return;
    }

    cout << "\n--- Login History ---\n";
    while (temp)
    {
        cout << "Account No: " << temp->accNo << endl;
        temp = temp->next;
    }
}

/* =========================
   BST OPERATIONS
   ========================= */
BSTNode *insertBST(BSTNode *root, int accNo, Account *accRef)
{
    if (!root)
    {
        BSTNode *node = new BSTNode;
        node->accNo = accNo;
        node->accRef = accRef;
        node->left = node->right = NULL;
        return node;
    }

    if (accNo < root->accNo)
        root->left = insertBST(root->left, accNo, accRef);
    else
        root->right = insertBST(root->right, accNo, accRef);

    return root;
}

Account *searchBST(BSTNode *root, int accNo)
{
    if (!root)
        return NULL;

    if (root->accNo == accNo)
        return root->accRef;

    if (accNo < root->accNo)
        return searchBST(root->left, accNo);

    return searchBST(root->right, accNo);
}
