#include <iostream>
#include <vector>
#include <stack>
#include <cstdlib>  
using namespace std;

void topologicalSortAux(const vector<vector<int>>& graph, int i, vector<bool>& visited, stack<int>& s) {
    visited[i] = true;
    for (int j : graph[i]) {
        if (not visited[j]) {
            topologicalSortAux(graph, j, visited, s);
        }
    }
    s.push(i);
}

stack<int> topologicalSort(const vector<vector<int>>& graph) {
    int n = graph.size();
    vector<bool> visited(n, false);
    stack<int> s;
    for (int i = 0; i < n; ++i) {
        if (not visited[i]) {
            topologicalSortAux(graph, i, visited, s);
        }
    }
    return s;

}

//devuelve si graph es un dag o no lo es
bool isDag(vector<vector<int>> graph) {
    int n = graph.size();
    vector<bool> visited(n, false);
    stack<int> s = topologicalSort(graph); 
    for (int i = 0; i < s.size(); ++i) {
        int node = s.top();
        for (int neighbour : graph[node]) {
            if (not visited[neighbour]) visited[neighbour] = true;
            else return false;
        }
    }
    return true;
}

//construira un dag de prerequisits dels n llibres que tinguem
vector<vector<int>> createDag(int n) {
    //used[i] sera true quan i tingui algun successor. Aixi ens assegurem de no crear cicles
    //ja que fem que un llibre amb succesors no pugui ser succesor de un altre
    vector<bool> used(n, false); 
    vector<vector<int>> graph(n);
    for (int i = 0; i < n; ++i) {
        int k = (rand()%n)* 0.3; //Cada llibre pot tenir com a maxim un 30% dels llibres totals com a successors 
        for (int j = 0; j < k; ++k) {
            int possibleSuccessor = rand()%n;
            int p = rand()%5 + 1; //Cada llibre te una probabilitat de 0.4 de tenir un nou successor si el llibre no esta usat 
            if (not used[possibleSuccessor] and p <= 2) {
                used[i] = true;
                graph[i].push_back(possibleSuccessor);
            }
        }
    }
    return graph;
}

void readAnswer() {
    //lee la respuesta
}

void isCorrect() {
    
}

void printProblem() {
    
}

int main() {

}