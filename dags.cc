#include <iostream>
#include <vector>
#include <cstdlib>  
#include <ctime>
using namespace std;

//construira un dag de prerequisits dels n llibres que tinguem
vector<vector<int>> createDag(int n) {
    //used[i] sera true quan i tingui algun successor. Aixi ens assegurem de no crear cicles
    //ja que fem que un llibre amb succesors no pugui ser succesor de un altre
    vector<bool> used(n, false); 
    vector<vector<int>> graph(n);
    srand(time(NULL)); //per canviar la semilla del random 
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            int p = rand()%5 + 1; //Cada llibre te una probabilitat de 0.6 de tenir un nou successor si el llibre no esta usat 
            if (j != i and not used[j] and p <= 2) {
                used[i] = true;
                graph[i].push_back(j);
            }
        }
    }
    return graph;
}

//(prerequisito libro1 libro6) -> hay que leer libro6 para leer libro1
void printDependences(const vector<vector<int>>& graph) {
    int i = 0;
    for (vector<int> v : graph) {
        for (int k = 0; k < v.size(); ++k) {
            cout << "(prerequisito libro" << v[k] << " libro" << i << ')' << endl;
        }
        ++i;
    }
}

void printGraph(const vector<vector<int>>& graph) {
    int n = graph.size();
    int i = 0;
    for (vector<int> v : graph) {
        cout << "successors del llibre " << i << ": ";
        for (int k = 0; k < v.size(); ++k) {
            cout << "llibre" << v[k];
            if (k != v.size() - 1) cout << ", ";
        }
        cout << endl;
        ++i;
    }
}

void printGraph(int n) {
    for (int i = 0; i < n; ++i) {
        cout << "(quiere_leer libro" << i << ")" << endl;
    }
    
}

int main() {
    vector<vector<int>> graph = createDag(7);
    printGraph(graph); 
    cout << endl;
    printDependences(graph);
    cout << endl;
}