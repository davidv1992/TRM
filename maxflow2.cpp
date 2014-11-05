#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <cctype>
#include <cmath>
#include <string>
#include <iostream>
#include <sstream>
#include <vector>
#include <map>
#include <set>
#include <list>
#include <queue>
#include <stack>
#include <deque>
#include <algorithm>

using namespace std;
#define DTYPE int
#define INF (1<<30)
#define EXTRA_CHECK
#undef EXTRA_CHECK
#define EXTRA_CHECK if (edgecap[f][j] == 0) continue;
#define CTYPE int
#define CINF (1 << 30)
#undef EXTRA_CHECK
#define EXTRA_CHECK if (edgecap[cur][i] == 0) continue;
vector<vector<int> > edges;
vector<vector<DTYPE> > edgecost;
vector<vector<CTYPE> > edgecap;
vector<DTYPE> pot;
vector<pair<int, int> > from;
vector<DTYPE> dist;
void dijkstras(int start)
{
        int NODES = edges.size();
        
        priority_queue<pair<int, int> > work;
        vector<bool> done(NODES, false);
        
        dist.clear();
        dist.resize(NODES, INF);
        from.clear();
        from.resize(NODES, make_pair(-1,0));
        
        dist[start] = 0;
        work.push(make_pair(0, start));
        
        while (!work.empty())
        {
                int cur = work.top().second;
                work.pop();
                
                if (done[cur])
                        continue;
                
                done[cur] = true;
                
                for (int i=0; i<edges[cur].size(); i++)
                {
                        int t = edges[cur][i];
                        int c = edgecost[cur][i];
                        
                        if (done[t] || dist[cur] + c >= dist[t])
                                continue;
                        
                        EXTRA_CHECK
                        
                        dist[t] = dist[cur] + c;
                        from[t] = make_pair(cur,i);
                        work.push(make_pair(-dist[t], t));
                }
        }
}
pair<int, int> maxflow2(int source, int sink)
{
        int n = edges.size();
        int flow = 0, cost = 0;
        pot.clear();
        pot.resize(n, 0);
        vector<vector<int> > medge(0);
        for (int i=0; i<n; i++)
                medge.push_back(vector<int >(edges[i].size(), -1));
        
        while (1)
        {
                dijkstras(source);
                
                if (dist[sink] == INF)
                        break;
                
                // find maxadd
                CTYPE maxadd = CINF;
                int cur = sink;
                while (cur != source)
                {
                        maxadd = min(maxadd, edgecap[from[cur].first][from[cur].second]);
                        cur = from[cur].first;
                }
                
                cost += (pot[sink] + dist[sink])*maxadd;
                flow += maxadd;
                
                // potential adjust
                for (int i=0; i<n; i++)
                {
                        for (int j=0; j<edges[i].size(); j++)
                        {
                                edgecost[i][j] += dist[i] - dist[edges[i][j]];
                        }
                        pot[i] += dist[i];
                }
                
                // adjust edges
                cur = sink;
                while (cur != source)
                {
                        int f = from[cur].first;
                        int j = from[cur].second;
                        edgecap[f][j] -= maxadd;
                        if (medge[f][j] == -1)
                        {
                                medge[f][j] = edges[cur].size();
                                medge[cur].push_back(j);
                                edges[cur].push_back(f);
                                edgecost[cur].push_back(0);
                                edgecap[cur].push_back(maxadd);
                        }
                        else
                        {
                                edgecap[cur][medge[f][j]] += maxadd;
                        }
                        cur = f;
                }
        }
        
        return make_pair(flow, cost);
}

int main()
{
        int n, e, source, sink;
        scanf("%d %d %d %d", &n, &e, &source, &sink);

        edges.clear();
        edges.resize(n, vector<int>(0));
        edgecost.clear();
        edgecost.resize(n, vector<DTYPE>(0));
        edgecap.clear();
        edgecap.resize(n, vector<CTYPE>(0));

        for (int i=0; i<e; i++)
        {
                int f, t, c, cap;
                scanf("%d %d %d %d", &f, &t, &c, &cap);
                edges[f].push_back(t);
                edgecost[f].push_back(c);
                edgecap[f].push_back(cap);
        }
        
        pair<int, int> result = maxflow2(source, sink);
        
        printf("%d %d\n", result.first, result.second);
        
        return 0;
}
