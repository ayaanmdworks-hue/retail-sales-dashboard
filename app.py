import dash
from dash import dcc, html
import pandas as pd
import plotly.express as px

monthly_trend = pd.read_csv('dashboard_data/monthly_trend.csv')
top_products = pd.read_csv('dashboard_data/top_products.csv')
revenue_by_country = pd.read_csv('dashboard_data/revenue_by_country.csv')
rfm_base = pd.read_csv('dashboard_data/rfm_base.csv')

total_revenue = monthly_trend['revenue'].sum()
total_customers = rfm_base['customer_id'].nunique()
avg_order_value = total_revenue / rfm_base['frequency'].sum()

fig_trend = px.line(monthly_trend, x='month', y='revenue', title='Monthly Revenue Trend', markers=True)
fig_products = px.bar(top_products.sort_values('total_revenue'), x='total_revenue', y='description', orientation='h', title='Top 10 Products by Revenue')
fig_country = px.bar(revenue_by_country.head(10).sort_values('total_revenue'), x='total_revenue', y='country', orientation='h', title='Top 10 Countries by Revenue')
fig_segment = px.histogram(rfm_base, x='segment', title='Customer Segments (RFM)')

app = dash.Dash(__name__)
server = app.server

app.layout = html.Div([
    html.H1("Retail Sales & Customer Intelligence Dashboard", style={'textAlign': 'center'}),
    html.Div([
        html.Div([html.H3(f"Rs {total_revenue:,.0f}"), html.P("Total Revenue")], style={'textAlign': 'center', 'width': '33%'}),
        html.Div([html.H3(f"{total_customers:,}"), html.P("Total Customers")], style={'textAlign': 'center', 'width': '33%'}),
        html.Div([html.H3(f"Rs {avg_order_value:,.2f}"), html.P("Avg Order Value")], style={'textAlign': 'center', 'width': '33%'}),
    ], style={'display': 'flex', 'justifyContent': 'space-around', 'margin': '20px'}),
    dcc.Graph(figure=fig_trend),
    dcc.Graph(figure=fig_products),
    dcc.Graph(figure=fig_country),
    dcc.Graph(figure=fig_segment),
])

if __name__ == '__main__':
    app.run(debug=True)